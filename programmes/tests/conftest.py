import pytest
from programmes.models import Manifesto
from programmes.models import Candidate


@pytest.fixture(scope="session")
def django_db_setup(django_db_setup, django_db_blocker):
    with django_db_blocker.unblock():
        Manifesto.objects.create(
            name="L'avenir en commun",
            summary="Résumé du programme de l'avenir en commun",
            website="https://melenchon2022.fr",
            candidate=Candidate.objects.create(
                first_name="Jean-Luc",
                last_name="Mélenchon",
                profession="Super job",
                website="https://melenchon.fr",
                photo="lien-vers-super-photo.com",
                biography="Super bio"))
