(require hyccup.defmacros [defhtml])

(import hyccup.page [include-css html5])

(defn render-in-page [#* content]
  (html5
    ['head
      ['meta {'charset "UTF-8"}]
      #* (include-css "/static/style.css")]
    ['body
      ['nav 
        ['ul 
          ['li ['a "Programmes"]] 
          ['li ['a "Comparateur"]]]
        ['p {'class "site-name"} "Programme" ['span "2022"]]]
      (iter content)]))
