(require hyccup.defmacros [defhtml defelem])

(import functools [cache])

(import django.urls [reverse]
        hyccup.element [link-to]
        hyccup.page [html5]
        programmes.util.render [include-scss]
        programmes.models [Manifesto])

(defn render-in-page [#* content [home? False]]
  (html5
    ['head
      ['meta {'charset "UTF-8"}]
      #* (include-scss "/static/style/style.scss")]
    ['body
      (navbar {'class (when home? "nav--home")})

      ['div {'id "content"} (iter content)]
      
      ;
      ['footer 
        ['p "Created by Origénial"]
        ['a {'href "https://github.com/Arkelis/programmes-2022" 'class "github"} ['img {'src "static/github.png" 'width "20px" 'class "github"}] ]]
    ]))

(defelem navbar []
  ['nav 
    ['ul 
      ['li (link-to (reverse "manifesto-list") "Programmes")
        ['div {'class "nav-submenu-container"} (manifesto-submenu)]]]
    (link-to {'class "site-name"} (reverse "home") "Programmes" ['span "2022"])])

(defn manifesto-submenu []
  ['ul {'class "nav-submenu"}
    (gfor 
      manifesto (Manifesto.objects.all)
      ['li 
        (link-to (reverse "manifesto-detail" :args [manifesto.slug])
          ['div {'class "manifesto"} (str manifesto)]
          ['div {'class "candidate-party"} (str manifesto.candidate) f" ({manifesto.candidate.party})"])])])
