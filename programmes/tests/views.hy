(import django.test [Client])

(import programmes.util.html [to-text])

(defn test-home-page []
  (setv resp (.get (Client) "/"))
  (assert (in "En mai prochain se déroulera en France l'élection présidentielle de 2022."
              (to-text resp.content))))
