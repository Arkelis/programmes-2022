(import pathlib [Path]
        shutil [rmtree])

(import pytest
        django.core.management [call-command])

(import programmes.models [Manifesto])


#@(pytest.fixture
(defn ensure-deleted-site-dir []
  (rmtree "site" :ignore-errors True)
  (yield)
  (rmtree "site")))


#@(pytest.fixture
(defn manifesto []
  (Manifesto.objects.get :name "L'avenir en commun")))


#@(pytest.mark.django-db
(defn test-export [ensure-deleted-site-dir manifesto]
  (call-command "export")
  
  (assert (.is-dir (Path "site")))
  (assert (.is-dir (Path "site/programmes/")))
  (assert (.is-dir (Path f"site/programmes/{manifesto.slug}/")))
  (assert (.is-file (Path f"site/programmes/{manifesto.slug}/index.html")))))
