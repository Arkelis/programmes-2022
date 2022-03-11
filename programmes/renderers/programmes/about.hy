(import
  hyccup.element [link-to]
  programmes.renderers.layouts.page [render-in-page])

(defn render []
  (render-in-page
    ['h1 "À propros de Programmes-2022.fr"]
    ['p ['em "www.programmes-2022.fr"] 
        " est un site internet destiné à exposer en ligne de manière
         claire et équitable les programmes de l'ensemble des candidats à
         l'Élection présidentielle de 2022. Le code source de ce site, ainsi que
         son contenu sont ouverts et disponibles sur "
        (link-to {'target "_blank"}
          "https://github.com/Arkelis/programmes-2022"
          "GitHub")
         "."]
    ['h2 "Hébergement"]
    ['p "Ce site internet, édité à titre non professionnel est hébergé par
         l'entreprise " ['em "GitHub B.V."] " siégant à l'adresse
         Vijzelstraat 68-72, 1017 HL Amsterdam (Pays-Bas) via son service Github
         Pages. Les coordonnées des contributeurs ont été transmises à
         l'entreprise assurant l'hébergement du site."]
    ['h2 "Données personnelles"]
    ['p "Ce site internet ne collecte " ['em "aucune donnée personnelle"] " et
         n'effectue aucune mesure d'audience. GitHub peut être amené à stocker
         les adresses IP des visiteurs, plus d'informations sur "
         (link-to {'target "_blank"}
           "https://docs.github.com/en/pages/getting-started-with-github-pages/about-github-pages#data-collection"
           "le site de l'hébergeur")]
        "."
    :style "about"))
