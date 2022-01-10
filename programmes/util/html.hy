(require hyrule [->> ->])

(import bs4 [BeautifulSoup])

(defn to-text [html-string]
  "Extract text from HTML.

  Example input:
      <p>Cupcake Ipsum.</p><p>Another paragraph.</p>

  Gives:
      Cupcake Ipsum. Another paragraph.
  
  Whitespaces are stripped.
  "
  (->> ;; retrieve a list of all texts
       (-> html-string
           (BeautifulSoup "html.parser")
           (. stripped-strings))
       ;; make it a big string and
       ;; remove all duplicate whitespaces
       (.join " ")
       (.split)
       (.join " ")))
