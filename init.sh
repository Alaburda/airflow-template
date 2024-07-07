#!/bin/bash

init_airflow() {
    curl -LsSf https://astral.sh/uv/install.sh | sh
    uv venv
    source .venv/bin/activate
    uv pip sync requirements.txt

}

run_airflow() {
    export AIRFLOW_HOME="$(pwd)/airflow"
    export AIRFLOW__CORE__DAGS_FOLDER="$(pwd)/dags"
    export AIRFLOW__CORE__MAX_ACTIVE_RUNS_PER_DAG=1
    export AIRFLOW__CORE__LOAD_EXAMPLES=True
    if [[ "$1" == "prod" ]]; then
        export AIRFLOW__DATABASE__SQL_ALCHEMY_CONN="postgresql+psycopg2://airflow_user:airflow_pass@localhost/airflow_db"
        export AIRFLOW__CORE__EXECUTOR=LocalExecutor
    else
        export AIRFLOW__DATABASE__SQL_ALCHEMY_CONN="sqlite:////$(pwd)/airflow/airflow.db"
        export AIRFLOW__CORE__EXECUTOR=SequentialExecutor
    fi

    airflow db migrate

    airflow users create \
        --username adminas \
        --firstname Peter \
        --lastname Parker \
        --role Admin \
        --email spiderman@superhero.org

    airflow scheduler -D

    airflow webserver --port 8080 -D

}

postgres() {
    sudo apt update && sudo apt upgrade
    sudo apt install postgresql postgresql-contrib
    sudo service postgresql start
    sudo su - postgres bash -c "psql -c \"CREATE DATABASE airflow_db;\""
    sudo su - postgres bash -c "psql -c \"CREATE USER airflow_user WITH PASSWORD 'airflow_pass';\""
    sudo su - postgres bash -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE airflow_db TO airflow_user;\""
    sudo su - postgres bash -c "psql -c \"GRANT ALL ON SCHEMA public TO airflow_user;\""
}

"$@"
