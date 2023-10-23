# !bin/bash 
set -x

# Downloading BQ connector JAR to nodes of Dataproc Cluster
gsutil cp gs://spark-lib/bigquery/spark-bigquery-with-dependencies_2.12-0.32.2.jar /usr/lib/spark/jars/