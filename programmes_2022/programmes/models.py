from django.db import models


class Candidate(models.Model):
    name = models.CharField(verbose_name="Nom du candidat", max_length=128)
    party = models.ForeignKey(
        "PoliticalPartyOrMovement",
        verbose_name="Parti ou mouvement politique",
        on_delete=models.SET_NULL,
        null=True)
    profession = models.CharField(verbose_name="Métier du candidat", max_length=128)
    website = models.URLField(verbose_name="Site web du candidat")
    photo = models.ImageField(verbose_name="Photo du candidat")
    biography = models.TextField(verbose_name="Biographie synthétique")


class Term(models.Model):
    candidate = models.ForeignKey(
        "Candidate",
        verbose_name="Candidat ayant effectué ce mandat",
        on_delete=models.CASCADE)
    start_date = models.DateField(verbose_name="Début du mandat")
    end_date = models.DateField(verbose_name="Fin du mandat")
    position = models.ForeignKey(
        "PoliticalPosition",
        verbose_name="Position occupée lors du mandat",
        on_delete=models.SET_NULL,
        null=True)
    summary = models.TextField(verbose_name="Résumé des actions menées lors du mandat")


class PoliticalPosition(models.Model):
    name = models.CharField(verbose_name="Nom de la position", max_length=128)


class PreviousPresidentialElection(models.Model):
    year = models.IntegerField(verbose_name="Année de l'élection")


class PreviousPresientialResult(models.Model):
    election = models.ForeignKey(
        "PreviousPresidentialElection",
        verbose_name="Election concernée",
        on_delete=models.CASCADE)
    result = models.FloatField()
    candidat = models.ForeignKey("Candidate", verbose_name="Candidat", on_delete=models.CASCADE)


class PoliticalPartyOrMovement(models.Model):
    name = models.CharField(verbose_name="Nom du parti ou du mouvement politique", max_length=128)
    summary = models.TextField(verbose_name="Description")
    website = models.URLField(verbose_name="Site internet")


class Manifesto(models.Model):
    name = models.CharField(verbose_name="Nom du programme", max_length=128)
    candidate = models.ForeignKey(
        "Candidate",
        verbose_name="Candidat qui porte ce programme",
        on_delete=models.SET_NULL,
        null=True)
    summary = models.TextField(verbose_name="Résumé synthétique du programme")
    website = models.URLField()


class Topic(models.Model):
    name = models.CharField(verbose_name="Titre de la thématique", max_length=128)


class ManifestoPragraph(models.Model):
    topic = models.ForeignKey("Topic", on_delete=models.CASCADE)
    text = models.TextField(verbose_name="Texte du paragraphe")
