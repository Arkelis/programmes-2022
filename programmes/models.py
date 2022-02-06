from django.db import models
from django.utils.text import slugify

        
class Candidate(models.Model):
    first_name = models.CharField(verbose_name="Prénom du candidat", max_length=128)
    last_name = models.CharField(verbose_name="Nom du candidat", max_length=128)
    party = models.ForeignKey(
        "PoliticalEntity",
        verbose_name="Parti, mouvement ou coalition politique",
        on_delete=models.SET_NULL,
        null=True,
        blank=True)
    profession = models.CharField(verbose_name="Métier du candidat", max_length=128)
    website = models.URLField(verbose_name="Site web du candidat")
    photo = models.ImageField(verbose_name="Photo du candidat", upload_to="img/")
    biography = models.TextField(verbose_name="Biographie synthétique")
    is_active = models.BooleanField(verbose_name="Afficher le candidat", default=True)

    class Meta:
        verbose_name = "candidat"
        ordering = ["last_name"]

    def __str__(self):
        return f"{self.first_name} {self.last_name}"


class Term(models.Model):
    candidate = models.ForeignKey(
        "Candidate",
        verbose_name="Candidat ayant effectué ce mandat",
        on_delete=models.CASCADE)
    start_date = models.DateField(verbose_name="Début du mandat")
    end_date = models.DateField(verbose_name="Fin du mandat", blank=True, null=True)
    position = models.ForeignKey(
        "PoliticalPosition",
        verbose_name="Position occupée lors du mandat",
        on_delete=models.SET_NULL,
        null=True,
        blank=True)
    summary = models.TextField(verbose_name="Résumé des actions menées lors du mandat")

    class Meta:
        verbose_name = "mandat"

    def __str__(self):
        base = f"{self.candidate} - {self.position.name}"
        dates = (
            f"depuis {self.start_date.year}"
            if (end_date := self.end_date) is None
            else f"de {self.start_date.year} à {end_date.year}")
        return f"{base} {dates}"


class PoliticalPosition(models.Model):
    name = models.CharField(verbose_name="Nom de la position", max_length=128)

    class Meta:
        verbose_name = "fonction politique"
        verbose_name_plural = "fonctions politiques"

    def __str__(self):
        return self.name


class PreviousPresidentialElection(models.Model):
    year = models.IntegerField(verbose_name="Année de l'élection")

    class Meta:
        verbose_name = "élection présidentielle passée"
        verbose_name_plural = "élections présidentielles passées"

    def __str__(self):
        return f"Election présidentielle de {self.year}"


class PreviousPresidentialResult(models.Model):
    election = models.ForeignKey(
        "PreviousPresidentialElection",
        verbose_name="Election concernée",
        on_delete=models.CASCADE)
    result = models.FloatField(verbose_name="Résultat")
    candidate = models.ForeignKey("Candidate", verbose_name="Candidat", on_delete=models.CASCADE)

    class Meta:
        verbose_name = "score à une élection présidentielle passée"
        verbose_name_plural = "scores aux élections présidentielles passées"

    def __str__(self):
        return f"{self.election.year} / {self.candidate} : {self.result:.2f} %"


class PoliticalEntity(models.Model):
    name = models.CharField(verbose_name="Nom du parti ou du mouvement politique", max_length=128)
    summary = models.TextField(verbose_name="Description")
    website = models.URLField(verbose_name="Site internet")
    parent = models.ForeignKey("PoliticalEntity", on_delete=models.SET_NULL, blank=True, null=True)
    photo = models.ImageField(verbose_name="Logo du parti", upload_to="img/", blank=True, null=True)

    class Meta:
        verbose_name = "entité politique"
        verbose_name_plural = "entités politiques"

    def __str__(self):
        return self.name

class ActiveManifestoManager(models.Manager):
    def get_queryset(self):
        return super().get_queryset().filter(candidate__is_active=True)
        
class Manifesto(models.Model):
    name = models.CharField(verbose_name="Nom du programme", max_length=128)
    candidate = models.OneToOneField(
        "Candidate",
        verbose_name="Candidat qui porte ce programme",
        on_delete=models.SET_NULL,
        null=True,
        blank=True)
    summary = models.TextField(verbose_name="Résumé synthétique du programme")
    website = models.URLField()

    objects = models.Manager()
    active_objects = ActiveManifestoManager()
    class Meta:
        verbose_name = "programme"
        ordering = ["name"]

    def __str__(self):
        return self.name

    @property
    def slug(self):
        return slugify(self.name)

class Topic(models.Model):
    name = models.CharField(verbose_name="Titre de la thématique", max_length=128)

    class Meta:
        verbose_name = "thème"

    def __str__(self):
        return self.name


class ManifestoParagraph(models.Model):
    topic = models.ForeignKey("Topic", verbose_name="thème", on_delete=models.CASCADE)
    text = models.TextField(verbose_name="Texte du paragraphe")
    manifesto = models.ForeignKey(
        "Manifesto",
        verbose_name="programme",
        related_name="paragraphs",
        related_query_name="paragraph",
        on_delete=models.CASCADE)

    class Meta:
        verbose_name = "paragraphe de programme"
        verbose_name_plural = "paragraphes des programmes"

    def __str__(self):
        return f"{self.manifesto.name} / {self.topic}"
