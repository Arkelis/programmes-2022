(require hyrule [doto])

(import
  django.contrib [admin]
  django.urls [include path]
  django.conf [settings]
  django.conf.urls.static [static])

(setv
  admin.site.site-header "Administration de Programmes-2022.fr"
  admin.site.site-title "Administration de Programmes-2022.fr"
  admin.site.index-title "Administration et Contenus")

(setv urlpatterns
  (doto 
    [(path "admin/" admin.site.urls)
     (path "" (include "programmes.urls"))]
    (.extend (static settings.MEDIA_URL :document_root settings.MEDIA_ROOT))))
