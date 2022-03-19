(require hyccup.defmacros [defhtml defelem])

(import functools [cache])

(import django.urls [reverse]
        hyccup.element [link-to]
        hyccup.page [html5]
        programmes.util.render [include-scss]
        programmes.models [Manifesto Topic])

(defn render-in-page 
  [#*
   content
   [home? False]
   [title ""]
   [description ""]
   [url ""]
   style]
  (html5 :lang "fr"
    ['head
      ['title title]
      ['link {'rel "canonical" 'href url}]
      ['meta {'property "og:locale" 'content "fr_FR"}]
      ['meta {'property "og:site_name" 'content "Programmes 2022"}]
      ['meta {'property "og:title" 'content title}]
      ['meta {'property "og:url" 'content url}]
      ['meta {'property "og:description" 'content description}]
      ['meta {'charset "UTF-8"}]
      ['meta {'name "viewport" 'content "width=device-width, initial-scale=1"}]
      #* (include-scss f"/static/css/{style}.scss")]
    ['body
      ['header (navbar {'class (when home? "nav--home")})]
      ['main {'id "content"} (iter content)]
      (footer home?)]))

(defelem navbar []
  ['nav
    ['ul
      ['li (link-to (reverse "home") "Accueil")]
      ['li (link-to (reverse "manifesto-list") "Programmes")
        ['div {'class "nav-submenu-container"} (manifesto-submenu)]]
      ['li (link-to (reverse "topic-list") "Thématiques")
        ['div {'class "nav-submenu-container"} (topic-submenu)]]]
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
          ['span (link-to (reverse "about") "À propos / Mentions légales")]
          ['span (link-to {'target "_blank"} "https://github.com/Arkelis/programmes-2022" "Code source")]]]]))

#@(cache
(defn manifesto-submenu []
  ['ul.nav-submenu.nav-submenu--manifesto
    #* (lfor 
      manifesto (Manifesto.active_objects.all)
      ['li 
        (link-to (reverse "manifesto-detail" :args [manifesto.slug])
          ['div {'class "manifesto"} (str manifesto)]
          ['div {'class "candidate-party"} (str manifesto.candidate) f" ({manifesto.candidate.party})"])])]))


#@(cache
(defn topic-submenu []
  ['ul.nav-submenu.nav-submenu--topic
    #* (lfor 
      topic (Topic.objects.all)
      ['li 
        (link-to (reverse "topic-detail" :args [topic.slug])
          ['div {'class "manifesto"} topic.name])])]))
