(require hyrule [->>])

(import
  django.utils.text [slugify]
  django.urls [reverse]
  hyccup.element [link-to]
  programmes.renderers.layouts.page [render-in-page]
  programmes.util.render [markdown])

(defn render [manifestos]
  (->> #** (dict
             :title f"Les programmes - Programmes 2022"
             :description f"Liste des programmes pour l'Élection présidentielle de 2022."
             :url "https://www.programmes-2022.fr/programmes/"
             :style "manifesto-list")
  (render-in-page
    ['div.title-container ['h1 "Les programmes"]]
    ['ul.manifesto-list
      (gfor manifesto manifestos
        ['li
          (link-to f"#{(slugify manifesto.name)}"
            ['div.manifesto manifesto.name]
            ['div.candidate-party (str manifesto.candidate) f" ({manifesto.candidate.party})"])])]
    #* (map manifesto-hero manifestos))))

(defn manifesto-hero [manifesto]
  ['section.container--manifesto-hero {'id (slugify manifesto.name)}
    ['div.manifesto-hero
      ['h1 manifesto.name]
      ['p {'class "candidate-party"} manifesto.candidate f" ({manifesto.candidate.party})"]
      ['h2 "En bref"]
      ['div {'class "manifesto-summary"} (markdown manifesto.summary)]
      (link-to (reverse "manifesto-detail" :args [manifesto.slug]) ['h2 "Lire les propositions ➜"])]])
