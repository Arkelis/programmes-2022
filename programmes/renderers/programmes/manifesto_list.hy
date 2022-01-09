(import
  [django.urls [reverse]]
  [hyccup.element [link-to]]
  [programmes.renderers.layouts.page [render-in-page]])

(defn render [manifestos]
  (render-in-page
    ['ul
      (gfor manifesto manifestos
        ['li (link-to (reverse "manifesto-detail" :args [manifesto.slug]) manifesto.name)])]))
