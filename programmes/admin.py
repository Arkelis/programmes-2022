from django.contrib import admin

from .models import Candidate
from .models import Manifesto
from .models import ManifestoParagraph
from .models import PoliticalEntity
from .models import PoliticalPosition
from .models import PreviousPresidentialElection
from .models import PreviousPresidentialResult
from .models import Term
from .models import Topic


admin.site.register([PoliticalPosition, PoliticalEntity, Topic])


@admin.register(Candidate)
class CandidateAdmin(admin.ModelAdmin):
    class ManifestoInline(admin.StackedInline):
        model = Manifesto

    class PreviousPresidentialResultInline(admin.StackedInline):
        model = PreviousPresidentialResult

    class TermInline(admin.StackedInline):
        model = Term

    list_display = ['__str__', 'party', 'manifesto']
    ordering = ['last_name']
    inlines = [ManifestoInline, PreviousPresidentialResultInline, TermInline]


@admin.register(Term)
class TermAdmin(admin.ModelAdmin):
    list_display = ['candidate', 'position', 'start_date', 'end_date']
    ordering = ['candidate']


@admin.register(PreviousPresidentialResult)
class PreviousPresidentialResultAdmin(admin.ModelAdmin):
    list_display = ['election', 'candidate', 'formatted_result']
    ordering = ['election', 'candidate']

    @admin.display(description='Résultat')
    def formatted_result(self, obj):
        return '{:.2f} %'.format(obj.result)


@admin.register(Manifesto)
class ManifestoAdmin(admin.ModelAdmin):
    class ManifestoParagraphInline(admin.StackedInline):
        model = ManifestoParagraph

    inlines = [ManifestoParagraphInline]
    list_display = ['__str__', 'candidate']
    ordering = ['name']


@admin.register(ManifestoParagraph)
class ManifestoParagraphAdmin(admin.ModelAdmin):
    list_display = ['__str__']
    ordering = ['manifesto']


@admin.register(PreviousPresidentialElection)
class PreviousPresidentialElectionAdmin(admin.ModelAdmin):
    class PreviousPresidentialResultInline(admin.StackedInline):
        model = PreviousPresidentialResult
        verbose_name = 'Résultat de candidat'
        verbose_name_plural = 'Résultats des candidats'

    inlines = [PreviousPresidentialResultInline]
