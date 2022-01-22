(require hyccup.defmacros [defhtml])

(import hyccup.page [html5]
        programmes.util.render [include-scss])

(defn render-in-page [#* content]
  (html5
    ['head
      ['meta {'charset "UTF-8"}]
      #* (include-scss "/static/style/style.scss")]
    ['body
      ['nav 
        ['ul 
          ['li ['a "Programmes"]] 
          ['li ['a "Comparateur"]]]
        ['p {'class "site-name"} "Programme" ['span "2022"]]]
      (iter content)]))
