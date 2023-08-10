import pyspark
from pyspark.sql import SparkSession
from pyspark.sql import functions as F 
from pyspark.sql import types
from pyspark.conf import SparkConf
from pyspark.context import SparkContext
import requests
import pandas as pd
from io import StringIO
import argparse 

# Configure variables as required
from config_variables import var_credentials_location, var_gcs_connector, var_cluster_temp_bucket, var_bq_dataset, var_gcs_bronze_bucket

# Default Area List
area_list = ['Central', 'Inner', 'Outer']

# Default Column List
column_list = ["Date", "UUID", "Weather", "Time", "Day", "Area", "Count"]

# Google Cloud Storage Bucket
storage_bucket_url = "gs://pipelineproject01-data-bronze-bucket/raw"

# Bike Data Schema
bike_schema = types.StructType([
    types.StructField('Year', types.IntegerType(), True), 
    types.StructField('UnqID', types.StringType(), True), 
    types.StructField('Date', types.StringType(), True), 
    types.StructField('Weather', types.StringType(), True), 
    types.StructField('Time', types.TimestampType(), True), 
    types.StructField('Day', types.StringType(), True), 
    types.StructField('Round', types.StringType(), True), 
    types.StructField('Dir', types.StringType(), True), 
    types.StructField('Path', types.StringType(), True), 
    types.StructField('Mode', types.StringType(), True), 
    types.StructField('Count', types.IntegerType(), True)
])

def create_spark_session(app_name: str , temp_bucket: str) -> SparkSession:
    '''
    Function to create Spark session on a Dataproc cluster 
    '''
    conf = SparkConf() \
        .setAppName(app_name) \
        .set("temporaryGcsBucket", temp_bucket) 

    
    spark = SparkSession.builder \
        .config(conf=conf) \
        .getOrCreate()
    
    return spark 


def gcs_to_bq(spark: SparkSession, gc_bucket: str, dataset: str, start_year: int, end_year: int, area_list: list, column_list: list) -> None:
    '''
    Function to read files into spark from Google Cloud Storage and transfer to BigQuery
    '''

    for year in range(start_year, end_year +1):
        unioned_df = None 

        for area in area_list:
            
            file_name = f"{gc_bucket}/{year}/{area}/*"

            df = spark.read \
                .option("header", "true") \
                .schema(bike_schema) \
                .csv(file_name)

            df = df \
                .withColumn("Date", F.to_date(df["Date"], "dd/MM/yyyy")) \
                .withColumn("Time", F.date_format(df["Time"], "HH:mm:ss")) \
                .withColumnRenamed("UnqID", "UUID") \
                .withColumn("Area", F.lit(area)) \
                .select(column_list)
            
            df.createOrReplaceTempView("temp_data")

            df_data = spark.sql("""
            select 
                    UUID
                    ,Area
                    ,Date
                    ,Time
                    ,Day
                    ,CASE
                        WHEN Weather IN 
                            ('Dry', 'Dry/hot', 'Dry Warm', 'Dry & Windy', 'Dry Chill', 'Dry/cold', 'Sunny Dry'
                            , 'Sun', 'Bright', 'Sunny', 'Sunny Overcast', 'Sunny/cloudy', 'Partly Sunny', 'Bright + Cloudy'
                            ,'Sun Setting' ,'Sunny + Cloudy' ,'Fine/dry', 'Good', 'Fine', "Sun", "Dry              ..."
                            , "Dry/ Sunny", "Cloudy/sunny", "Warm + Dry", "Druy", "Dry", "Dry/Sunny", "Dry/sun", "Fine + Dry"
                            , "Dry/good", "Dry/mild", "Fine + Hot", "Fair", "Sunny Dry", "Dry/sunny", " Dry") 
                        THEN 'Clear/Sunny'
                        WHEN Weather IN 
                            ('Cloudy', 'Cloudy/dry', 'Overcast', 'Cloudy Sunny' , 'Cloudy + Sunny', 'Cold/cloudy'
                            ,'Dry/overcast', "Dark/cloudy", "Dark Cloudy", "Dull") 
                        THEN 'Cloudy'
                        WHEN Weather IN 
                            ('Wet/damp', 'Wet ', 'Very Wet', 'Damp', 'Drizzle', 'Light Shrs', 'Mizzle'
                            ,'V. Light Drizzle', 'Light Rain', 'Drizzly]', 'Drtizzly', 'Drizzel', 'Drizzly'
                            ,'Light Showers', 'Dry Wet Road' ,'Mix Wet/dry', 'V. Light Drizzle', 'Dry Wet Road'
                            , "S.wet", "S/w", "Wet", "Wet/dry", "Showers", "S. Wet", "Shower", "Some Showers"
                            , "Road Wet", "Dry/wet") 
                        THEN 'Light Rain'
                        WHEN Weather IN 
                            ('Windy/rain', 'Windy + Sunny', 'Wind/ Showers', 'Windy + Sunny', 'Windy', 'Windy/rain'
                            ,'Rain & Cloudy', 'Windy/wet', 'Rain & Windy', 'Windy/rain', 'Very Windy', 'Cloudy + Rain'
                            ,'Cloudy/rain/sunny' , 'Sunsetting + Windy', 'High Wind' ,'Cold', 'Cold/cloudy'
                            , "Cloudy/rain", "Rain", "Wet And Windy", "Dry/windy", "Dry Very Windy", "Raining"
                            , "Wet/windy", "Dry Cold", "Rain/cloudy", "Heavy Rain", "Cold/sunny", "Cloudy/windy"
                            , "Wet/v.windy", "Rains", "Dark/dry", "Dry/dark", "Dark Dry", "Dry Dark") 
                        THEN 'Windy/Rainy/Cold'
                        ELSE "Unknown"
                    END AS GroupedWeather 
                    ,Count
            from 
                    temp_data 
            ;
            """)

            if unioned_df == None:
                unioned_df = df_data

            else:
                unioned_df = unioned_df.unionAll(df_data)

        unioned_df.write \
            .format("bigquery") \
            .option("table", f"{dataset}.{year}-data") \
            .save()
        
        print(f"Loaded {year}-data into BQ")
        
    return None



if __name__ == "__main__":
    # When run as script - all data will be moved to BQ

    spark = create_spark_session("Transfer to BQ", var_cluster_temp_bucket)

    gcs_to_bq(spark, var_gcs_bronze_bucket, var_bq_dataset, 2015, 2022, area_list, column_list)