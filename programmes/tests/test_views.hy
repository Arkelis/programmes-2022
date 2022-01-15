(import pytest)

(import programmes.util.html [to-text]
        programmes.models [Manifesto Candidate])

;; Fixture provided by pytest-django:
;; - client: an instance of django.test.Client

#@(pytest.fixture
(defn manifesto []
  (Manifesto.objects.get :name "L'avenir en commun")))


(defn test-home-page [client]
  (setv resp (client.get "/"))
  (assert (in "En mai prochain se déroulera en France l'élection présidentielle de 2022."
              (to-text resp.content))))


#@(pytest.mark.django-db
(defn test-list-programmes [client manifesto]
  (setv resp (client.get "/programmes/"))
  (assert (in manifesto.name (to-text resp.content)))))


#@(pytest.mark.django-db
(defn test-detail-programme [client manifesto]
  (setv resp (client.get "/programmes/lavenir-en-commun/"))
  (assert (in manifesto.name (to-text resp.content)))))
