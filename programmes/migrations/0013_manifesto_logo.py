# Generated by Django 4.0.1 on 2022-03-06 21:37

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('programmes', '0012_alter_candidate_options_alter_manifesto_options_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='manifesto',
            name='logo',
            field=models.ImageField(null=True, upload_to='img/', verbose_name='Logo du programme'),
        ),
    ]
