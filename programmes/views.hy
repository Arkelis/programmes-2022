(require
  hyrule [->])

(import programmes.models [Manifesto]
        programmes.util.render [render])

(defn home [request]
  (render "programmes/home"))

(defn manifesto-list [request]
  (setv manifestos (Manifesto.active_objects.all))
  (render 
    "programmes/manifesto_list"
    :manifestos manifestos))

(defn manifesto-detail [request slug]
  (setv manifesto
    (-> (filter
          (fn [x] (= slug x.slug))
          (Manifesto.objects.iterator))
      (next)))
  (render 
    "programmes/manifesto_detail"
    :manifesto manifesto))

(defn candidate-list [request]
  (render "programmes/candidate_list"))

(defn about [request]
  (render "programmes/about"))

(defn legals [request]
  (render "programmes/legals"))