(require hyrule [->])

(import
  django.utils.text [slugify]
  django.conf [settings]
  django.urls [reverse]
  programmes.models [Manifesto ManifestoParagraph]
  programmes.renderers.layouts.page [render-in-page]
  programmes.util.render [markdown]
  hyccup.element [link-to]
  hyccup.core [raw])

(defn render [topic]
  (setv manifestos (Manifesto.active-objects.all))
  (render-in-page
    ['div.title-container
      ['h1 topic.name]]
    (paragraphs manifestos topic)
    :title f"{topic.name} - Programmes 2022"
    :description f"Liste des propositions des programmes pour l'Élection présidentielle de 2022
                   sur le thème {topic.name}."
    :url f"https://www.programmes-2022.fr/thematiques/{topic.slug}/"
    :style "topic"))

(defn toc [paragraphs topic]
    ['div {'class "manifesto-toc"}
      (link-to "#top" ['h2.title topic.name])
      (gfor paragraph paragraphs
        (link-to f"#{paragraph.manifesto.slug}" paragraph.manifesto.name))])
  
(defn paragraphs [manifestos topic]
  (let [paragraphs (-> ManifestoParagraph.objects
                       (.filter :topic__name topic.name)
                       (.order-by "manifesto__order"))]
  ['section {'class "container--manifesto-paragraphs"}
    (toc paragraphs topic)
    ['div {'class "manifesto-paragraphs"}
      (gfor paragraph paragraphs
            ['section {'class "manifesto-paragraph"}
              ['div {'class "breadcrumb" 'aria-hidden True}
                (link-to (reverse "topic-list") "Thématiques") " / "
                (link-to "#top" topic.name)
                ['div (link-to {'title "Lire l'ensemble des propositions de ce programme"}
                        (reverse "manifesto-detail" :args [paragraph.manifesto.slug]) paragraph.manifesto.name)]]
              ['h1 {'id paragraph.manifesto.slug}
                (link-to {'title "Lire l'ensemble des propositions de ce programme"}
                  (reverse "manifesto-detail" :args [paragraph.manifesto.slug]) paragraph.manifesto.name)
                ['span paragraph.manifesto.candidate]]
              (markdown paragraph.text)])]]))
