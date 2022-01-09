(import [django.urls [path]]
        [. [views]])

(setv urlpatterns
  [(path "" views.home :name "home")
   (path "programmes" views.programmes :name "programmes")
   (path "candidates" views.candidates :name "candidates")])
