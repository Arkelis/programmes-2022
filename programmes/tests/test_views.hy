(import pytest)

(import programmes.util.html [to-text]
        programmes.models [Manifesto Candidate])

;; Fixture provided by pytest-django:
;; - client: an instance of django.test.Client

#@(pytest.fixture
(defn manifesto []
  (Manifesto.objects.get :name "L'avenir en commun")))

#@(pytest.mark.django-db
(defn test-home-page [client]
  (setv resp (client.get "/")
        content (to-text resp.content))
  (assert (in "L'avenir en commun" content))
  (assert (in "Jean-Luc Mélenchon (La France insoumise)" content))
  (assert (in "En mai prochain se déroulera en France l'élection présidentielle de 2022."
              content))))


#@(pytest.mark.django-db
(defn test-list-programmes [client manifesto]
  (setv resp (client.get "/programmes/"))
  (assert (in manifesto.name (to-text resp.content)))))


#@(pytest.mark.django-db
(defn test-detail-programme [client manifesto]
  (setv resp (client.get "/programmes/lavenir-en-commun/"))
  (assert (in manifesto.name (to-text resp.content)))))
