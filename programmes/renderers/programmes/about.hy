(import
  programmes.renderers.layouts.page [render-in-page])

(defn render []
  (render-in-page
    ['h1 "A propros"]
    :style "home"))
