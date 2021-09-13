(import [django.apps [AppConfig]])

(defclass ProgrammesConfig [AppConfig]
  (setv default-auto-field "django.db.models.BigAutoField"
        name "programmes"))
