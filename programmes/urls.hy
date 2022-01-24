(import django.urls [path]
        programmes [views])

(setv urlpatterns
  [(path "" views.home :name "home")
   (path "apropos/" views.about :name "about")
   (path "mentions-legales/" views.legals :name "legals")
   (path "programmes/" views.manifesto-list :name "manifesto-list")
   (path "programmes/<slug>/" views.manifesto-detail :name "manifesto-detail")
   (path "candidates/" views.candidate-list :name "candidate-list")])
