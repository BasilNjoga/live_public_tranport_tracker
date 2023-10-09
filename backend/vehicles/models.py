from django.db import models


class VehicleDetail(models.Model):
    number_plate = models.CharField(max_length=256)
    bus_sacco = models.CharField(max_length=256)
    driver_id = models.IntegerField(blank=False)
    route = models.CharField(max_length=256)

    def __str__(self):
        return self.number_plate + " " + self.bus_sacco
    #live_location