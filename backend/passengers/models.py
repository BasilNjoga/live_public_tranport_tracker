from django.db import models
from django.utils.translation import gettext_lazy as _
from django.contrib.postgres import fields as PostgresFields

# Create your models here.

class PassengerDetail(models.Model):
    name = models.CharField(max_length=256, blank=False)
    email = models.EmailField(blank=False)
    isincar = models.BooleanField(blank=False)
    location = models.CharField(max_length=256)

    def __str__(self):
        return self.name

"""
class VehicleDetails(models.Model):
    bus_sacco = models.CharField(max_length=256)
    driver_id = models.IntegerField()
    #live_location

class RouteDetails(models.Model):
   start = models.CharField(max_length=256)
   stop = models.CharField(max_length=256)
"""
