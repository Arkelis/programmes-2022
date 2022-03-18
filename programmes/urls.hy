(import django.urls [path]
        programmes [views])

(setv urlpatterns
  [(path "" views.home :name "home")
   (path "a-propos/" views.about :name "about")
   (path "programmes/" views.manifesto-list :name "manifesto-list")
   (path "programmes/<slug>/" views.manifesto-detail :name "manifesto-detail")
   (path "thematiques/" views.topic-list :name "topic-list")
   (path "thematiques/<slug>/" views.topic-detail :name "topic-detail")
   (path "candidates/" views.candidate-list :name "candidate-list")])
