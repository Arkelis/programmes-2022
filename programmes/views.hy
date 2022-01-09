(require [util.render [render]])

(import [django.http [HttpResponse]])

(defn home [request]
  (render "programmes/home"))

(defn programmes [request]
  (render "programmes/programmes"))

(defn candidates [request]
  (render "programmes/candidates"))
