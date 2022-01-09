(require [util.render [render]])

(defn home [request]
  (render "programmes/home"))

(defn programmes [request]
  (render "programmes/programmes"))

(defn candidates [request]
  (render "programmes/candidates"))
