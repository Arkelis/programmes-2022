# programmes-2022.fr

[![Tests](https://github.com/Arkelis/programmes-2022/actions/workflows/ci.yml/badge.svg)](https://github.com/Arkelis/programmes-2022/actions/workflows/ci.yml)

Website about candidates and their manifesto for 2022 French Presidential Elections.
Work in progress, still not released.

## Overview

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

### Build the website locally

Clone the repository and `cd` into it.

Then, run the setup script, it will setup the project and build the website in you machine.
You need to have Poetry and Python 3.9+ installed.

```
sh ./scripts/dev-env-setup.sh
```

This builds the website into the `site` directory.
You can now navigate on the exported website with:

### Develop

For develop, launch the Django development server to hot reload views:

```
python manage.py runserver
```

## More information

Refer to the [wiki](https://github.com/Arkelis/programmes-2022/wiki) (French)!
