(require hyccup.defmacros [defhtml defelem])

(import functools [cache])

(import django.urls [reverse]
        hyccup.element [link-to]
        hyccup.page [html5]
        programmes.util.render [include-scss]
        programmes.models [Manifesto])

(defn render-in-page [#* content [home? False] [manifesto-title None] style ]
  (html5
    ['head
      ['meta {'charset "UTF-8"}]
      ['meta {'name "viewport" 'content "width=device-width, initial-scale=1"}]
      #* (include-scss f"/static/css/{style}.scss")]
    ['body
      ['header (navbar {'class (when home? "nav--home")} manifesto-title)]
      ['main {'id "content"} (iter content)]]
      (footer home?)))

(defelem navbar [manifesto-title]
  ['nav
    ['ul
      ['li (link-to (reverse "home") "Accueil")]
      ['li (link-to (reverse "manifesto-list") "Programmes")
        ['div {'class "nav-submenu-container"} (manifesto-submenu)]]
      (if manifesto-title ['li (link-to "#top" manifesto-title)])]
    ['div {'class "site-name"} "Programmes" ['span "2022"]]])

#@(cache
(defelem footer [home?]
    ['footer
      ['div
        (if (not home?)
          ['div
            ['h3 {'class "title"} "Les programmes"]
            ['div {'class "manifestos"}
              #* (lfor
                  manifesto (Manifesto.active_objects.all)
                  ['span (link-to (reverse "manifesto-detail" :args [manifesto.slug]) (str manifesto))])]])
      
        ['p {'class "title"} "Programmes-2022.fr"]
        ['p
          ['span (link-to (reverse "about") "À propos du site")]
          ['span (link-to (reverse "about") "Mentions légales")]
          ['span (link-to {'target "_blank"} "https://github.com/Arkelis/programmes-2022" "Code source")]]]]))

#@(cache
(defn manifesto-submenu []
  ['ul {'class "nav-submenu"}
    #* (lfor 
      manifesto (Manifesto.active_objects.all)
      ['li 
        (link-to (reverse "manifesto-detail" :args [manifesto.slug])
          ['div {'class "manifesto"} (str manifesto)]
          ['div {'class "candidate-party"} (str manifesto.candidate) f" ({manifesto.candidate.party})"])])]))
