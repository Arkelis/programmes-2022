(import [hyccup.core [html]]
        [hyccup.page [html5]])

(defn render [context]
  (html5 ["p" "Hello big big world!"]))

