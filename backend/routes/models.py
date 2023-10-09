from django.db import models

# Create your models here.
class RouteDetail(models.Model):
   start = models.CharField(max_length=256)
   stop = models.CharField(max_length=256)