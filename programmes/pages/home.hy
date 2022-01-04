(import
  [hyccup.core [html]]
  [hyccup.page [html5 include-css]])
  
(defn render []
  (html5
    ['head
      #* (include-css "/static/style.css")]
    ['div {'class "container"}
      ['div {'class "center-block"}
        ['h1 
          ['span {'class "title-word"} "Programmes"]
          ['span {'class "title-year"} "2022"]]
        ['div {'class "abstract"}
          "En mai prochain se déroulera en France l'élection présidentielle de 2022.
           S'il s'agira d'élire la personnalité qui guidera la politique du pays pour
           les cinq prochaines années, ce site va tenter de synthétiser les programmes
           portés par chacun des candidats, afin de vous éclairer dans votre choix."]]]))
