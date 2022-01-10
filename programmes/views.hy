(require
  hyrule [->] 
  programmes.util.render [render])

(import programmes.models [Manifesto])

(defn home [request]
  (render "programmes/home"))

(defn manifesto-list [request]
  (setv manifestos (Manifesto.objects.all))
  (render 
    "programmes/manifesto_list"
    {"manifestos" manifestos}))

(defn manifesto-detail [request slug]
  (setv manifesto
    (-> (filter
          (fn [x] (= slug x.slug))
          (Manifesto.objects.iterator))
      (next)))
  (render 
    "programmes/manifesto_detail"
    {"manifesto" manifesto}))

(defn candidate-list [request]
  (render "programmes/candidate_list"))
