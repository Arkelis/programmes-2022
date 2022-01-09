(import
  [importlib [import-module]]
  [django.http [HttpResponse]])


(defn resolve-renderer-module [module-name [where-to-search (, "programmes." "")]]
  (setv [to-search #* others] where-to-search)
  (try 
    (. (import-module f"{to-search}renderers.{module-name}") render __module__)
    (except [ModuleNotFoundError ImportError]
      (if others
        (resolve-renderer-module module-name others)
        (raise (RuntimeError f"Temlate for {page-name} does not exist"))))))


(defmacro render [page-name [context {}]]
  "Return an HttpResponse with rendered page.
  
  Try to find the correct page module and call render() function in it.
  (render \"programmes/home\") renders programmes.templates.programmes.home
  "
  (setv page-module (.replace (str page-name) "/" ".")
        resolved-module-name (resolve-renderer-module page-module))
  `(do
     (import [importlib [import-module]])
     (HttpResponse
       (-> 
         (import-module ~resolved-module-name)
         (.render #** ~context)))))

