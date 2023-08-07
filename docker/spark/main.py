import pyspark
from pyspark.sql import SparkSession
from pyspark.conf import SparkConf
from pyspark.context import SparkContext
from config_variables import var_credentials_location, var_gcs_connector
import requests
import pandas as pd
from io import StringIO


