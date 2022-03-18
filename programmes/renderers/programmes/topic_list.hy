(require hyrule [->>])

(import
  django.utils.text [slugify]
  django.urls [reverse]
  hyccup.element [link-to]
  programmes.renderers.layouts.page [render-in-page]
  programmes.util.render [markdown])

(defn render [topics]
  (->> #** (dict
             :title f"Les thématiques - Programmes 2022"
             :description f"Liste des thématiques pour l'Élection présidentielle de 2022."
             :url "https://www.programmes-2022.fr/thematiques/"
             :style "topic-list")
  (render-in-page
    ['div.title-container ['h1 "Les thématiques"]]
    ['ul.manifesto-list
      (gfor topic topics
        ['li
          (link-to (reverse "topic-detail" :args [topic.slug])
            ['div.manifesto topic.name])])])))
