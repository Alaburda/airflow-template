curl -LsSf https://astral.sh/uv/install.sh | sh
exec bash
uv venv
source .venv/bin/activate
uv pip sync requirements.txt
export AIRFLOW_HOME="$(pwd)/airflow"
export AIRFLOW__CORE__DAGS_FOLDER="$(pwd)/dags"
export AIRFLOW__CORE__EXECUTOR=SequentialExecutor
export AIRFLOW__CORE__MAX_ACTIVE_RUNS_PER_DAG=1
export AIRFLOW__CORE__LOAD_EXAMPLES=True
export AIRFLOW__CORE__LOAD_EXAMPLES=True

airflow users create \
    --username adminas \
    --firstname Peter \
    --lastname Parker \
    --role Admin \
    --email spiderman@superhero.org

airflow scheduler -D

airflow webserver --port 8080 -D
