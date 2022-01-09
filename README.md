# programmes-2022.fr

Website about candidates and their manifesto for 2022 French Presidential Elections.
Work in progress, still not released.

## Structure of the repository

### Technology

The project use the following technologies:

- Python as main programming language
- Django: fullstack web framework
- Hy: a lisp embed in Python and Hyccup for HTML rendering
- Poetry for package management

### Django project structure

There is one application called `programmes` in which the models and views are defined.
A command exporting the website as static files is also exposed in this application.
Some files are written in Hy.

### Develop

To contribute, clone the repository and install the dependencies with Poetry:

```sh
poetry install
```

You may want to retrieve a database with some data (ask me), then you can
export the website

```sh
poetry run python manage.py export
```

You can now navigate on the exported website with

```sh
poetry run python -m http.server -d site 
```
