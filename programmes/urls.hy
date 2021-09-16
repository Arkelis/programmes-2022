(import [django.urls [path]]
        [. [views]])

(setv urlpatterns
  [(path "" views.home :name "home")])
