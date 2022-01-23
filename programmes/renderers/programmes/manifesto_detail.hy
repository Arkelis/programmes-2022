(import
  django.urls [reverse]
  hyccup.element [link-to]
  programmes.renderers.layouts.page [render-in-page]
  programmes.util.render [markdown])

(defn render [manifesto]
  (render-in-page
    (intro manifesto)
    (paragraphs manifesto)
   :style "manifesto"))

(defn intro [manifesto]
  ['div {'class "container--manifesto-intro"}
    ['div {'class "manifesto-intro"}
      ['h1 manifesto.name]
      ['p {'class "candidate-party"} manifesto.candidate f" ({manifesto.candidate.party})"]
      ['h2 "En bref"]
      ['div {'class "manifesto-summary"} (markdown manifesto.summary)]]])

(defn paragraphs [manifesto]
  ['section {'class "container--manifesto-paragraphs"}
    ['div {'class "manifesto-paragraphs"}
      ['h1 "Propositions par thématiques"]
      (gfor paragraph (manifesto.paragraphs.all)
            ['section {'class "manifesto-paragraph"}
              ['h1 paragraph.topic]
              (markdown paragraph.text)])]])
