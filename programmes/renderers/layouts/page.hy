(require hyccup.defmacros [defhtml])

(import django.urls [reverse]
        hyccup.element [link-to]
        hyccup.page [html5]
        programmes.util.render [include-scss])

(defn render-in-page [#* content]
  (html5
    ['head
      ['meta {'charset "UTF-8"}]
      #* (include-scss "/static/style/style.scss")]
    ['body
      (navbar)
      (iter content)]))

(defn navbar []
  ['nav 
    ['ul 
      ['li ['a "Programmes"]] 
      ['li ['a "Comparateur"]]]
    (link-to {'class "site-name"} (reverse "home") "Programmes" ['span "2022"])])
