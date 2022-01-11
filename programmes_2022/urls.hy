(import
  django.contrib [admin]
  django.urls [include path])

(setv
  admin.site.site-header "Administration de Programmes-2022.fr"
  admin.site.site-title "Administration de Programmes-2022.fr"
  admin.site.index-title "Administration et Contenus")

(setv urlpatterns
  [(path "admin/" admin.site.urls)
   (path "" (include "programmes.urls"))])
