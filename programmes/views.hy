(require
  hyrule [->])

(import programmes.models [Manifesto Topic]
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


(defn topic-list [request]
  (setv topics (Topic.objects.all))
  (render 
    "programmes/topic_list"
    :topics topics))

(defn topic-detail [request slug]
  (setv topic
    (-> (filter
          (fn [x] (= slug x.slug))
          (Topic.objects.iterator))
      (next)))
  (render 
    "programmes/topic_detail"
    :topic topic))

(defn candidate-list [request]
  (render "programmes/candidate_list"))

(defn about [request]
  (render "programmes/about"))
