curl -LsSf https://astral.sh/uv/install.sh | sh
exec bash
uv venv
source .venv/bin/activateexport PYTHON_VERSION="$(python -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')"
export AIRFLOW_VERSION=2.7.2
CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"
uv pip install "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"
uv pip install dbt-sqlserver==1.4.3
uv pip freeze | uv pip compile - -o requirements.txt

