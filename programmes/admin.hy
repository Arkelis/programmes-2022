(import 
  [django.contrib [admin]]
  [.models
    [Candidate
     Term
     PoliticalPosition
     PreviousPresidentialElection
     PreviousPresidentialResult
     PoliticalEntity
     Manifesto
     Topic
     ManifestoParagraph]])

(admin.site.register
  [PoliticalPosition
   PoliticalEntity
   Topic])


#@((admin.register Candidate)
(defclass CandidateAdmin [admin.ModelAdmin]
  (defclass ManifestoInline [admin.StackedInline]
    (setv model Manifesto))

  (defclass PreviousPresidentialResultInline [admin.StackedInline]
    (setv model PreviousPresidentialResult))

  (defclass TermInline [admin.StackedInline]
    (setv model Term))

  (setv 
    list-display ["__str__" "party" "manifesto"]
    ordering ["last_name"]
    inlines [ManifestoInline
             PreviousPresidentialResultInline
             TermInline])))

#@((admin.register Term)
(defclass TermAdmin [admin.ModelAdmin]
  (setv
    list-display ["candidate" "position" "start_date" "end_date"]
    ordering ["candidate"])))


#@((admin.register PreviousPresidentialResult)
(defclass PreviousPresidentialResultAdmin [admin.ModelAdmin]
  (setv
    list-display ["election" "candidate" "formatted_result"]
    ordering ["election" "candidate"])
  
  #@((admin.display :description "Résultat")
  (defn formatted-result [self obj]
    (.format "{:.2f} %" obj.result)))))


#@((admin.register Manifesto)
(defclass ManifestoAdmin [admin.ModelAdmin]
  (defclass ManifestoParagraphInline [admin.StackedInline]
    (setv model ManifestoParagraph))

  (setv
    inlines [ManifestoParagraphInline]
    list-display ["__str__" "candidate"]
    ordering ["name"])))


#@((admin.register ManifestoParagraph)
(defclass ManifestoParagraphAdmin [admin.ModelAdmin]
  (setv
    list-display ["topic" "manifesto"]
    ordering ["topic"])))


#@((admin.register PreviousPresidentialElection)
(defclass PreviousPresidentialElectionAdmin [admin.ModelAdmin]

  (defclass PreviousPresidentialResultInline [admin.StackedInline]
    (setv model PreviousPresidentialResult
          verbose-name "Résultat de candidat"
          verbose-name-plural "Résultats des candidats"))

  (setv inlines [PreviousPresidentialResultInline])))
