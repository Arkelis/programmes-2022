(import
  django.urls [reverse]
  hyccup.element [link-to]
  programmes.renderers.layouts.page [render-in-page])

(defn render [manifesto]
  (render-in-page
    (intro manifesto)))

(defn intro [manifesto]
  ['div {'class "container--manifesto-intro"}
    ['section {'class "manifesto-intro"}
      ['h1 manifesto.name]
      ['p {'class "candidate-party"} manifesto.candidate f" ({manifesto.candidate.party})"]]])
