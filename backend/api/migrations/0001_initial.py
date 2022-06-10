# Generated by Django 3.2.11 on 2022-06-10 14:39

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='House',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=120)),
                ('price', models.CharField(max_length=40)),
                ('plot', models.CharField(max_length=10)),
                ('bathrooms', models.IntegerField()),
                ('bedrooms', models.IntegerField()),
                ('living_space', models.CharField(max_length=10)),
                ('description', models.TextField(max_length=1500)),
                ('image', models.CharField(max_length=1000)),
                ('created', models.DateTimeField(auto_now_add=True)),
            ],
        ),
    ]
