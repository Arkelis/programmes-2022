(require hyrule [-> doto])

(import
  pathlib [Path]
  shutil [copytree rmtree])

(import
  bs4 [BeautifulSoup]
  django.core.management.base [BaseCommand CommandError]
  django.test [Client]
  django.urls [reverse]
  sass)

(import programmes.models [Manifesto Topic])


(defclass Command [BaseCommand]
  (setv
    help "Export the website"
    client (Client))

  (defn handle [self #* args #** options]
    (doto self
      (.setup-folder)
      (.content-at (reverse "home"))
      (.content-at (reverse "about"))
      (.contents-of Manifesto "manifesto-list" "manifesto-detail")
      (.contents-of Topic "topic-list" "topic-detail")
      (.copy-styles)
      (.copy-images))
    "Done! Result build is in 'site' folder.")
  
  (defn content-at [self url]
    (with [sm (open "site/sitemap.txt" "a")]
      (sm.write f"https://www.programmes-2022.fr{url}\n"))
    (.mkdir (Path f"site{url}") :exist_ok True :parents True)
    (with [f (open f"site{url}index.html" "w")]
      (self.stdout.write f"Writing site{url}index.html")
      (f.write
        (-> self.client
          (.get url)
          (. content)
          (.decode)
          (BeautifulSoup :features "html.parser")
          (.prettify)))))
  
  (defn contents-of [self model-cls list-name detail-name]
    (self.content-at (reverse list-name))
    (for [obj (model-cls.objects.iterator)]
      (self.content-at (reverse detail-name :args [obj.slug]))))
  
  (defn setup-folder [self]
    (setv site-path (Path "site"))
    (if (site-path.is-dir)
      (rmtree "site"))
    (site-path.mkdir))

  (defn copy-images [self]
    (when (.is-dir (Path "programmes/media/img"))
      (copytree "programmes/media/img" "site/media/img")))
  
  (defn copy-styles [self]
    (setv django-css-dir "programmes/static/css"
          site-css-dir "site/static/css")
    (.mkdir (Path site-css-dir) :exist_ok True :parents True)
    (for [scss-entry-point 
          (-> (Path django-css-dir) (.glob "[!_]*.scss"))]
      (setv scss-filename scss-entry-point.name
            css-filename (.replace scss-entry-point.name "scss" "css"))
      (with [f (open f"{site-css-dir}/{css-filename}" "w")]
        (self.stdout.write f"Writing {site-css-dir}/{css-filename}")
        (f.write (sass.compile :filename f"{django-css-dir}/{scss-filename}"))))))
