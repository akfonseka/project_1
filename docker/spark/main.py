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
from config_variables import var_credentials_location, var_gcs_connector, var_cluster_temp_bucket

# Area List
area_list = ['Central', 'Inner', 'Outer']


def create_spark_session(app_name: str , temp_bucket: str):
    conf = SparkConf() \
        .setAppName(app_name) \
        .set("temporaryGcsBucket", temp_bucket) 

    
    spark = SparkSession.builder \
        .config(conf=conf) \
        .getOrCreate()
    
    return spark 





