#!/usr/bin/env bash

DB_HOST=${DATABASE_HOST:-postgres}
DB_PORT=${DATABASE_PORT:-5432}

BE_HOST=${BACKEND_HOST:-frogress}
BE_PORT=${BACKEND_PORT:-8000}

until nc -z ${DB_HOST} ${DB_PORT} > /dev/null; do
    echo "Waiting for database to become available on ${DB_HOST}:${DB_PORT}..."
    sleep 1
done

poetry run python manage.py migrate

poetry run python manage.py runserver ${BE_HOST}:${BE_PORT}
