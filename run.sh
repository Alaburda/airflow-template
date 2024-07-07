airflow() {
    export AIRFLOW_HOME="$(pwd)/airflow"
    export AIRFLOW__CORE__DAGS_FOLDER="$(pwd)/dags"
    export AIRFLOW__CORE__MAX_ACTIVE_RUNS_PER_DAG=1
    export AIRFLOW__CORE__LOAD_EXAMPLES=True
    # if [[ "$1" == "prod" ]]; then
    #     export AIRFLOW__DATABASE__SQL_ALCHEMY_CONN="postgresql+psycopg2://airflow_user:airflow_pass@localhost/airflow_db"
    #     export AIRFLOW__CORE__EXECUTOR=LocalExecutor
    # else
    #     export AIRFLOW__DATABASE__SQL_ALCHEMY_CONN="sqlite:////$(pwd)/airflow/airflow.db"
    #     export AIRFLOW__CORE__EXECUTOR=SequentialExecutor
    # fi

    airflow scheduler -D

    airflow webserver --port 8080 -D

}