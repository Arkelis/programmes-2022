(import
  django.utils.text [slugify]
  django.urls [reverse]
  hyccup.element [link-to]
  programmes.renderers.layouts.page [render-in-page])

(defn render [manifestos]
  (render-in-page
    ['div.title-container ['h1 "Les programmes"]]
    ['ul.manifesto-list
      (gfor manifesto manifestos
        ['li
          (link-to f"#{(slugify manifesto.name)}"
            ['div.manifesto (str manifesto)]
            ['div.candidate-party (str manifesto.candidate) f" ({manifesto.candidate.party})"])])]
    (gfor manifesto manifestos
      ['div.manifesto-hero {'id (slugify manifesto.name)}
        ['p manifesto.summary]])
    :style "manifesto-list"))
