(import
  [django.urls [reverse]]
  [hyccup.element [link-to]]
  [programmes.renderers.layouts.page [render-in-page]])

(defn render [manifesto]
  (render-in-page
    ['p manifesto.name]))
