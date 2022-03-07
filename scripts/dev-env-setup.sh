#! /usr/bin/env sh

poetry install

echo 'DJANGO_SETTINGS_MODULE=programmes_2022.settings.devel' > .env

cp db.sqlite3 db.sqlite3.$(date +%s).bak
poetry run python manage.py migrate
poetry run python manage.py loaddata latest.json
poetry run pytest
poetry run python manage.py export
