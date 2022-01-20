from django.apps import AppConfig
from programmes.callbacks import compile_scss
from django.utils import autoreload

class ProgrammesConfig(AppConfig):
    default_auto_field = "django.db.models.BigAutoField"
    name = "programmes"


autoreload.autoreload_started.connect(compile_scss)
autoreload.file_changed.connect(compile_scss)
