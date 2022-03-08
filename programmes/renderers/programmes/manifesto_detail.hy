(import
  django.utils.text [slugify]
  django.conf [settings]
  django.urls [reverse]
  programmes.renderers.layouts.page [render-in-page]
  programmes.util.render [markdown]
  hyccup.element [link-to])

(defn render [manifesto]
  (render-in-page
    (intro manifesto)
    (paragraphs manifesto)
   :style "manifesto"
   :manifesto-title manifesto.name))

(defn toc [paragraphs]
    ['div {'class "manifesto-toc"}
      ['h2 "Thématiques" ]
      (gfor paragraph (paragraphs)
        ['a {'href (+ "#" (slugify paragraph.topic.name))} paragraph.topic])
      ['h2.hint
        "Cliquez sur une mesure pour plus de détails."]])

(defn intro [manifesto]
  ['div {'class "container--manifesto-intro"}
    ['div {'class "manifesto-intro"}
      ['img {'src (+ settings.MEDIA-URL (str manifesto.candidate.photo)) 'class "candidate"}]
      (if manifesto.logo
        ['h1 {'class "title--image"} 
          ['img {'src (+ settings.MEDIA-URL (str manifesto.logo)) 'class "party" 'alt "L'Avenir en commun"}]]
        ['h1 manifesto.name])
      ['p {'class "candidate-party"} manifesto.candidate f" ({manifesto.candidate.party})"]
      ['h2 "En bref"]
      ['div {'class "manifesto-summary"} (markdown manifesto.summary)]]])
  
(defn paragraphs [manifesto]
  ['section {'class "container--manifesto-paragraphs"}
    (toc manifesto.paragraphs.all)
    ['div {'class "manifesto-paragraphs"}
      (gfor paragraph (manifesto.paragraphs.all)
            ['section {'class "manifesto-paragraph"}
              ['div {'class "breadcrumb" 'aria-hidden True}
                (link-to (reverse "manifesto-list") "Programmes") " / "
                (link-to "#top" manifesto.name)
                ['div paragraph.topic.name]]
              ['h1 {'id (slugify paragraph.topic.name)} paragraph.topic]
              (markdown paragraph.text)])]])
