(import sass
        rich [inspect]
        django.utils [autoreload])

(defn compile-scss [sender #* args #** kwargs]
  (with [f (open "programmes/static/style.css" "w")]
    (f.write (sass.compile :filename "programmes/static/style.scss"))))
