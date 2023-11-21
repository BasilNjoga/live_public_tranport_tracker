from django.db import models


class VehicleDetail(models.Model):
    number_plate = models.CharField(max_length=256)
    bus_sacco = models.CharField(max_length=256)
    route = models.CharField(max_length=256)
    latitude = models.FloatField(default=0.0)
    longitude = models.FloatField(default=0.0)

    def __str__(self):
        return self.number_plate + " " + self.bus_sacco
    #live_location