from django.db import models


class House(models.Model):
    title = models.CharField(max_length=120)
    price = models.CharField(max_length=40)
    plot = models.CharField(max_length=10)
    bathrooms = models.IntegerField()
    bedrooms = models.IntegerField()
    living_space = models.CharField(max_length=10)
    description = models.TextField(max_length=1500)
    image = models.CharField(max_length=1000)
    created = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title