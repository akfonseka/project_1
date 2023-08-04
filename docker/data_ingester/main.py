import requests
import pandas as pd
from google.cloud import storage
from io import StringIO
from config_variables import var_gcs_bronze_bucket

# Initial URL for main web data source
base_url = r"https://cycling.data.tfl.gov.uk/ActiveTravelCountsProgramme/1-Strategic%20counts%20(CIO)"

# Area List
area_list = ['Central', 'Inner', 'Outer']

def upload_to_gcs(credentials_location: str, bucket: str, object_name: str, csv_data: pd.DataFrame, file_name:str) -> None:
    ''' 
    Function to upload data from local DataFrame to Google Cloud Storage
    '''

    csv_data.to_csv(file_name)

    storage_client = storage.Client.from_service_account_json(credentials_location)
    gc_bucket = storage_client.bucket(bucket)
    blob = gc_bucket.blob(object_name)
    blob.upload_from_string(file_name, content_type='text/csv')
    
    return None


def web_to_gcs(year: int, area: str) -> pd.DataFrame:
    '''
    Function to take data from online data source and upload to GCS
    '''

    url = f'{base_url}/{year}-{area}.csv'

    response = requests.get(url)
    
    df = pd.read_csv(StringIO(response.text))    
    
    return df


def file_name_creator(year: int, area: str) -> str:
    '''
    Function create appropriate filename
    '''
    file_name = f'{year}_{area}_bikedata.csv'

    return file_name


if __name__ == '__main__':

# When run as a script - bikedata between 2015-2022 for all 3 London areas will be downloaded to GCS Bucket

    for year in range(15,23):
        for area in area_list:
            file = file_name_creator(year, area)
            df = web_to_gcs(year, area)
            upload_to_gcs('./credentials.json', var_gcs_bronze_bucket, f'raw/{year}/{area}', df, file)
            print(f'GCS: raw/{year}/{area}')

