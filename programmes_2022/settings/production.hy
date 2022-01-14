(import os
        dotenv [load-dotenv])

(import programmes-2022.settings.common *)


(defn secret-key-from-env []
  (load-dotenv)
  (let [key (os.getenv "SECRET_KEY")]
    (if (is key None) 
      (raise (ValueError "No secrey key provided. Please provide a SECRET_KEY env variable."))
      (return key))))

(setv
  SECRET-KEY (secret-key-from-env)
  DEBUG False
  ALLOWED-HOSTS ["contenu.programmes-2022.fr"])
