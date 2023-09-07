gcloud dataproc jobs submit pyspark \
    --cluster=pipelineproject01-cluster \
    --region=europe-west2 \
    --jars=gs://spark-lib/bigquery/spark-bigquery-with-dependencies_2.12-0.23.2.jar \
    --py-files gs://pipelineproject01-code-bucket/code/config_variables.py \
    gs://pipelineproject01-code-bucket/code/spark_app.py
