(import [django.http [HttpResponse]]
        [. [pages]])

(defn home [request]
  (HttpResponse (pages.home.render {123 "123"})))
