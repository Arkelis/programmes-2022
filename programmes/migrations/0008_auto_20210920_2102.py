# Generated by Django 3.2.7 on 2021-09-20 21:02

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('programmes', '0007_auto_20210920_2018'),
    ]

    operations = [
        migrations.RenameField(
            model_name='candidate',
            old_name='name',
            new_name='last_name',
        ),
        migrations.AddField(
            model_name='candidate',
            name='first_name',
            field=models.CharField(default='Prénom', max_length=128, verbose_name='Prénom du candidat'),
            preserve_default=False,
        ),
    ]
