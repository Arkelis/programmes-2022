(import
  django.utils.text [slugify]
  django.conf [settings]
  programmes.renderers.layouts.page [render-in-page]
  programmes.util.render [markdown])

(defn render [manifesto]
  (render-in-page
    (menu manifesto.paragraphs.all manifesto.name)
    (intro manifesto)
    (paragraphs manifesto)  
   :style "manifesto"))

(defn menu [paragraphs title]
  ['div {'class "manifesto-menu"}
    ['a {'href "#intro"} ['h2 title ]]
    (gfor paragraph (paragraphs)
      ['a {'href (+ "#" (slugify paragraph.topic.name))} paragraph.topic])])

(defn intro [manifesto]
  ['div {'class "container--manifesto-intro" 'id "intro"}
    ['div {'class "manifesto-intro"}
      ['img {'src (+ settings.MEDIA-URL (str manifesto.candidate.party.photo)) 'class "party"}]
      ['img {'src (+ settings.MEDIA-URL (str manifesto.candidate.photo)) 'class "candidate"}]
      
      ['h1 manifesto.name]
      ['p {'class "candidate-party"} manifesto.candidate f" ({manifesto.candidate.party})"]
      ['h2 "En bref"]
      ['div {'class "manifesto-summary"} (markdown manifesto.summary)]]])
  
(defn paragraphs [manifesto]
  ['section {'class "container--manifesto-paragraphs"}
    ['div {'class "manifesto-paragraphs"}
      ['h1 "Propositions par thématiques"]
      (gfor paragraph (manifesto.paragraphs.all)
            ['section {'class "manifesto-paragraph"}
              ['div {'id (slugify paragraph.topic.name)}] ; empty div to have fixed anchor links
                ['h1 paragraph.topic]
                (markdown paragraph.text)])]])
