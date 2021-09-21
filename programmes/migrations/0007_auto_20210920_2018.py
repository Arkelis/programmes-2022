# Generated by Django 3.2.7 on 2021-09-20 20:18

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('programmes', '0006_alter_candidate_photo'),
    ]

    operations = [
        migrations.AlterField(
            model_name='candidate',
            name='photo',
            field=models.ImageField(upload_to='static/static/', verbose_name='Photo du candidat'),
        ),
        migrations.AlterField(
            model_name='previouspresidentialresult',
            name='result',
            field=models.FloatField(verbose_name='Résultat'),
        ),
    ]
