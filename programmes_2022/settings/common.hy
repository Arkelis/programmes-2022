(require hyrule [->])

(import pathlib [Path])

(setv
  BASE-DIR (-> (Path __file__) (.resolve) (. parent parent parent))
  INSTALLED-APPS
    ["django.contrib.admin"
     "django.contrib.auth"
     "django.contrib.contenttypes"
     "django.contrib.sessions"
     "django.contrib.messages"
     "django.contrib.staticfiles"
     "programmes"]
  MIDDLEWARE
    ["django.middleware.security.SecurityMiddleware"
     "django.contrib.sessions.middleware.SessionMiddleware"
     "django.middleware.common.CommonMiddleware"
     "django.middleware.csrf.CsrfViewMiddleware"
     "django.contrib.auth.middleware.AuthenticationMiddleware"
     "django.contrib.messages.middleware.MessageMiddleware"
     "django.middleware.clickjacking.XFrameOptionsMiddleware"]
  ROOT-URLCONF "programmes_2022.urls"
  TEMPLATES
    [{"BACKEND" "django.template.backends.django.DjangoTemplates"
      "DIRS" []
      "APP_DIRS" True
      "OPTIONS"
        {"context_processors" ["django.template.context_processors.debug"
                               "django.template.context_processors.request"
                               "django.contrib.auth.context_processors.auth"
                               "django.contrib.messages.context_processors.messages"]}}]
  WSGI-APPLICATION "programmes_2022.wsgi.application"
  DATABASES
    {"default" {"ENGINE" "django.db.backends.sqlite3"
                "NAME" (-> BASE_DIR (/ "db.sqlite3"))}}
  AUTH-PASSWORD-VALIDATORS
    [{"NAME" "django.contrib.auth.password_validation.UserAttributeSimilarityValidator"}
     {"NAME" "django.contrib.auth.password_validation.MinimumLengthValidator"}
     {"NAME" "django.contrib.auth.password_validation.CommonPasswordValidator"}
     {"NAME" "django.contrib.auth.password_validation.NumericPasswordValidator"}]
  LANGUAGE-CODE "fr-fr"
  TIME-ZONE "UTC"
  USE-I18N True
  USE-TZ True
  STATIC-URL "static/"
  MEDIA-URL "media/"
  MEDIA-ROOT "./programmes/media/"
  DEFAULT-AUTO-FIELD "django.db.models.BigAutoField")
