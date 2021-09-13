(import
  [django.contrib [admin]]
  [django.urls [include path]])

(setv urlpatterns
  [(path "admin/" admin.site.urls)
   (path "" (include "programmes.urls"))])
