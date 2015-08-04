docker run --name airflow-db -e MYSQL_ROOT_PASSWORD=airflow-db -d mysql:latest
sleep 10
docker run --name airflow --link airflow-db:mysql -p 8080:8080 -p 5555:5555 -d twistedogic/airflow

