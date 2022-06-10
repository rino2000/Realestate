from django.db import models
from django.urls import reverse
from django.contrib.auth.models import AbstractBaseUser


class House(models.Model):
    title = models.CharField(max_length=120)
    price = models.CharField(max_length=40)
    plot = models.CharField(max_length=10)
    bathrooms = models.IntegerField()
    bedrooms = models.IntegerField()
    living_space = models.CharField(max_length=10)
    description = models.TextField(max_length=1500)
    image = models.ImageField(max_length=1000)
    created = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title

    def get_absolute_url(self):
        return reverse('home')


class Broker(AbstractBaseUser):
    name = models.CharField(max_length=80, blank=False, null=False)
    email = models.EmailField(max_length=200, blank=False, null=False)
    password = models.CharField(max_length=40, blank=False, null=False)
    houses = models.ForeignKey(House, on_delete=models.CASCADE)
    created = models.DateTimeField(auto_now_add=True)

    USERNAME_FIELD = 'name'
    EMAIL_FIELD = 'email'

    class Meta:
        permissions = [
            ('create_house', 'Can create a house model')
        ]

    def __str__(self):
        return self.name

    def get_absolute_url(self):
        return reverse('home')
