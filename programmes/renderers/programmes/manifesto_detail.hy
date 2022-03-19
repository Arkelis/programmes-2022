(import
  django.utils.text [slugify]
  django.conf [settings]
  django.urls [reverse]
  programmes.renderers.layouts.page [render-in-page]
  programmes.util.render [markdown]
  hyccup.element [link-to]
  hyccup.core [raw])

(defn render [manifesto]
  (render-in-page
    (intro manifesto)
    (paragraphs manifesto)
    :title f"{manifesto.name}, le programme porté par {manifesto.candidate} - Programmes 2022"
    :description f"Liste des propositions du programme {manifesto.name} porté par
                   {manifesto.candidate} pour l'Élection présidentielle de 2022."
    :url f"https://www.programmes-2022.fr/programmes/{manifesto.slug}/"
    :style "manifesto"))

(defn toc [paragraphs manifesto]
    ['div {'class "manifesto-toc"}
      (link-to "#top" ['h2.title manifesto.name])
      (gfor paragraph paragraphs
        (link-to f"#{paragraph.topic.slug}" paragraph.topic))
      ['h2.hint
        "Cliquez sur une mesure" ['br] "pour plus de détails."]])

(defn intro [manifesto]
  ['div {'class "container--manifesto-intro"}
    ['div {'class "manifesto-intro"}
      ['img {'src (+ settings.MEDIA-URL (str manifesto.candidate.photo)) 'class "candidate" 'alt (raw "")}]
      (if manifesto.logo
        ['h1 {'class "title--image"} 
          ['img {'src (+ settings.MEDIA-URL (str manifesto.logo)) 'class "party" 'alt manifesto.name}]]
        ['h1 manifesto.name])
      ['p {'class "candidate-party"} manifesto.candidate f" ({manifesto.candidate.party})"]
      ['h2 "En bref"]
      ['div {'class "manifesto-summary"} (markdown manifesto.summary)]
      ['ul
        ['li (link-to {'target "_blank"} manifesto.website "Site web du programme ➜")]
        ['li (link-to {'target "_blank"} manifesto.candidate.website f"Site web de {manifesto.candidate} ➜")]]]])
  
(defn paragraphs [manifesto]
  (setv paragraphs (manifesto.paragraphs.order-by "order"))
  ['section {'class "container--manifesto-paragraphs"}
    (toc paragraphs manifesto)
    ['div {'class "manifesto-paragraphs"}
      (gfor paragraph paragraphs
            ['section {'class "manifesto-paragraph"}
              ['div {'class "breadcrumb" 'aria-hidden True}
                (link-to (reverse "manifesto-list") "Programmes") " / "
                (link-to "#top" manifesto.name)
                ['div (link-to {'title "Comparer les autres programmes sur cette thématique"}
                        (reverse "topic-detail" :args [paragraph.topic.slug])
                        paragraph.topic.name)]]
              ['h1 {'id paragraph.topic.slug}
                (link-to {'title "Comparer les autres programmes sur cette thématique"}
                  (reverse "topic-detail" :args [paragraph.topic.slug]) paragraph.topic.name)]
              (markdown paragraph.text)])]])
