(require hyrule [-> doto])

(import
  functools [cache]
  importlib [import-module]
  logging
  pathlib [Path])

(import
  django.http [HttpResponse]
  hyccup.page [include-css]
  sass)


(setv logger (doto (logging.getLogger "programmes.render.scss")
                   (.setLevel logging.DEBUG)
                   (.addHandler
                     (doto 
                       (logging.StreamHandler)
                       (.setLevel logging.DEBUG)
                       (.setFormatter 
                         (logging.Formatter
                           "[%(asctime)s] %(message)s"
                           :datefmt "%d/%b/%Y %H:%M:%S"))))))


(defn get-modified-time [path-str]
  (setv path (Path path-str))
  (cond 
    [(.is-file path) (. path (stat) st-mtime)]
    [(.is-dir path)
     (max (gfor 
            source-path (path.glob "**/*.scss") 
            (. source-path (stat) st-mtime)))]
    [True 0]))


(defn compile-if-needed [scss-uri]
  (setv scss-file-path f"programmes{scss-uri}"
        css-uri (.replace scss-uri ".scss" ".css")
        css-file-path f"programmes{css-uri}")
  (when (> (get-modified-time "programmes/static/style") 
           (get-modified-time css-file-path))
    (logger.info f"Compiling {scss-file-path}")
    (with [f (open css-file-path "w")]
      (f.write (sass.compile :filename scss-file-path))))
  css-uri)


(defn include-scss [#* styles]
  (include-css #* (map compile-if-needed styles)))


#@(cache
(defn resolve-renderer-module [module-name [where-to-search (, "programmes." "")]]
  (setv [to-search #* others] where-to-search)
  (try 
    (. (import-module f"{to-search}renderers.{module-name}") render __module__)
    (except [ModuleNotFoundError ImportError]
      (if others
        (resolve-renderer-module module-name others)
        (raise (RuntimeError f"Renderer for {page-name} does not exist")))))))


(defn render [page-name #** context]
  "Return an HttpResponse with rendered page.
  
  Try to find the correct page module and call render() function in it.
  (render \"programmes/home\") renders programmes.templates.programmes.home
  "
  (setv page-module (.replace (str page-name) "/" ".")
        resolved-module-name (resolve-renderer-module page-module))
  (HttpResponse
    (->
      (import-module resolved-module-name)
      (.render #** context))))

