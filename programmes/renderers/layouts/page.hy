(require hyccup.defmacros [defhtml defelem])

(import functools [cache])

(import django.urls [reverse]
        hyccup.element [link-to]
        hyccup.page [html5]
        programmes.util.render [include-scss]
        programmes.models [Manifesto])

(defn render-in-page [#* content [home? False] style]
  (html5
    ['head
      ['meta {'charset "UTF-8"}]
      ['meta {'name "viewport" 'content "width=device-width, initial-scale=1"}]
      #* (include-scss f"/static/css/{style}.scss")]
    ['body
      ['header (navbar {'class (when home? "nav--home")})]
      ['main {'id "content"} (iter content)]]
      
      (full-footer home?)))

(defelem navbar []
  ['nav
    ['ul
      ['li (link-to (reverse "manifesto-list") "Programmes")
        ['div {'class "nav-submenu-container"} (manifesto-submenu)]]]
    (link-to {'class "site-name"} (reverse "home") "Programmes" ['span "2022"])])

#@(cache
(defelem full-footer [home?]
    ['footer
      (if (not home?)
        ['div
          ['p {'class "title"} "Programmes"]
           ['div {'class "manifestos"}
             #* (lfor
                 manifesto (Manifesto.active_objects.all)
                 ['span (link-to (reverse "manifesto-detail" :args [manifesto.slug]) (str manifesto))])]])
      
      ['p {'class "title"} "Programmes 2022"]
        ['p
          ['span (link-to (reverse "about") "À propos du site")]
          ['span (link-to (reverse "legals") "Mentions légales")]
          ['span ['a {'href "https://github.com/Arkelis/programmes-2022" 'class "github"} 
              ['img {'src "/static/github.png"}] "Code source"]]]]))

#@(cache
(defn manifesto-submenu []
  ['ul {'class "nav-submenu"}
    #* (lfor 
      manifesto (Manifesto.active_objects.all)
      ['li 
        (link-to (reverse "manifesto-detail" :args [manifesto.slug])
          ['div {'class "manifesto"} (str manifesto)]
          ['div {'class "candidate-party"} (str manifesto.candidate) f" ({manifesto.candidate.party})"])])]))
