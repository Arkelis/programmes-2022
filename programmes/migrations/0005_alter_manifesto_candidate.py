# Generated by Django 3.2.7 on 2021-09-14 22:19

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('programmes', '0004_auto_20210914_2049'),
    ]

    operations = [
        migrations.AlterField(
            model_name='manifesto',
            name='candidate',
            field=models.OneToOneField(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='programmes.candidate', verbose_name='Candidat qui porte ce programme'),
        ),
    ]