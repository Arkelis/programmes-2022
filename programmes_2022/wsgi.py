"""
WSGI config for programmes_2022 project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/3.2/howto/deployment/wsgi/
"""

import os

from django.core.wsgi import get_wsgi_application
import hy

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'programmes_2022.settings')

application = get_wsgi_application()
