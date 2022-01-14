(import django.test [Client]
        pytest)

(import programmes.util.html [to-text]
        programmes.models [Manifesto Candidate])


#@(pytest.fixture
(defn manifesto []
  (Manifesto.objects.create
    :name "L'avenir en commun"
    :summary "Résumé du programme de l'avenir en commun"
    :website "https://melenchon2022.fr"
    :candidate (Candidate.objects.create
      :first-name "Jean-Luc"
      :last-name "Mélenchon"
      :profession "Super job"
      :website "https://melenchon.fr"
      :photo "lien-vers-super-photo.com"
      :biography "Super bio"))))


(defn test-home-page []
  (setv resp (.get (Client) "/"))
  (assert (in "En mai prochain se déroulera en France l'élection présidentielle de 2022."
              (to-text resp.content))))


#@(pytest.mark.django-db
(defn test-list-programmes [manifesto]
  (setv resp (.get (Client) "/programmes/"))
  (assert (in manifesto.name (to-text resp.content)))))


#@(pytest.mark.django-db
(defn test-detail-programme [manifesto]
  (setv resp (.get (Client) "/programmes/lavenir-en-commun/"))
  (assert (in manifesto.name (to-text resp.content)))))
