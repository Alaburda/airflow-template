airflow() {
    curl -LsSf https://astral.sh/uv/install.sh | sh
    exec bash
    uv venv
    source .venv/bin/activate
    uv pip sync requirements.txt
    

    airflow users create \
        --username adminas \
        --firstname Peter \
        --lastname Parker \
        --role Admin \
        --email spiderman@superhero.org

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


