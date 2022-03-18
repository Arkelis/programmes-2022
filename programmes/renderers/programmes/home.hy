(require hyrule [->>])

(import
  django.urls [reverse]
  hyccup.core [html]
  hyccup.element [link-to]
  hyccup.page [html5 include-css]
  programmes.renderers.layouts.page [render-in-page])
  
(defn render []
  (->> #** (dict
             :home? True
             :title "Programmes 2022 - Les programmes de l'Élection présidentielle de 2022"
             :description "Ce site internet expose les programmes portés par
                           les candidats de l'Élection présidentielle de 2022."
             :url "https://www.programmes-2022.fr/"
             :style "home")
    (render-in-page
      ['div {'class "container"}
        ['div {'class "center-block"}
          ['h1 
            ['span {'class "title-word"} "Programmes"]
            ['span {'class "title-year"} "2022"]]
          ['p {'class "abstract"}
            "En avril prochain se déroulera en France l'élection présidentielle de 2022.
             S'il s'agira d'élire la personnalité qui guidera la politique du pays pour
             les cinq prochaines années, ce site va tenter de synthétiser les programmes
             portés par chacun des candidats, afin de vous éclairer dans votre choix."]
          ['ul.milestones
            ['li.milestone "Premier tour : " ['em "10 avril 2022"]]
            ['li.milestone "Second tour : " ['em "24 avril 2022"]]]
          ['ul.links
            ['li (link-to {'class "link--programmes"} (reverse "manifesto-list") "Consulter les programmes des candidats ➜")]
            ['li (link-to {'class "link--programmes"} (reverse "topic-list") "Comparer les programmes par thématiques ➜")]]]])))
