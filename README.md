# programmes-2022.fr

Website about candidates and their manifesto for 2022 French Presidential Elections.
Work in progress, still not released.

## Structure of the repository

### Technology

The project use the following technologies:

- [Python](https://docs.python.org/) as main programming language
- [Django](https://docs.djangoproject.com/en/4.0/): fullstack web framework
- [Hy](https://docs.hylang.org/en/alpha/): a lisp embed in Python and [Hyccup](https://hyccup.pycolore.fr) for HTML rendering
- [Poetry](https://python-poetry.org/) for package management

### Django project structure

There is one application called `programmes` in which the models and views are defined.
A command exporting the website as static files is also exposed in this application.
Some files are written in Hy.

Instead of using Django templates, we use functions which return HTML. They are organized
in a close manner as if they were Django templates, in `renderers` package. Each module
exposes a `render()` function which is used by the views in `views.hy` to render pages. 

### Develop

To contribute, clone the repository and install the dependencies with Poetry:

```
poetry install
```

Install the database by executing Django migration:

```
poetry run python manage.py migrate
```

Load latest data:

```
poetry run python manage.py loaddata latest.json
```

Execute the test suite:

```
poetry run pytest
```

Export the website:

```
poetry run python manage.py export
```

This builds the website into the `site` directory.
You can now navigate on the exported website with:

```
poetry run python -m http.server -d site 
```
