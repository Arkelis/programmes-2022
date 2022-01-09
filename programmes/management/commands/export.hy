(import
  [pathlib [Path]]
  [shutil
    [copytree
     rmtree]]
  [django.test [Client]]
  [django.core.management.base
    [BaseCommand
     CommandError]]
  [django.urls [reverse]]
  sass
  [programmes.urls [urlpatterns]])


(defclass Command [BaseCommand]
  (setv
    help "Export the website"
    client (Client))

  (defn handle [self #* args #** options]
    (doto self
      (.setup-folder)
      (.content-at (reverse "home"))
      (.content-at (reverse "programmes"))
      (.content-at (reverse "candidates"))
      (.copy-assets))
    "Done! Result build is in 'site' folder.")
  
  (defn content-at [self url]
    (.mkdir (Path f"site{url}") :exist_ok True :parents True)
    (with [f (open f"site{url}/index.html" "w")]
      (f.write
        (-> self.client
          (.get url)
          (. content)
          (.decode)))))
  
  (defn setup-folder [self]
    (setv site-path (Path "site"))
    (if (site-path.is-dir)
      (rmtree "site"))
    (site-path.mkdir))
  
  (defn copy-assets [self]
    (sass.compile :dirname (, "programmes/static" "site/static"))))
