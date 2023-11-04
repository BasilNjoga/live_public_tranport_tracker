from django.db import models

# Create your models here.
class RouteDetail(models.Model):
   route_id = models.CharField(max_length=256)
   start = models.CharField(max_length=256)
   stop = models.CharField(max_length=256)

   def __str__(self):
      return self.stop


class StopDetail(models.Model):
   stop_id = models.CharField(max_length=256)
   stop_name = models.CharField(max_length=256,blank=True)
   stop_latitude = models.IntegerField(default=0)
   stop_longitude = models.IntegerField(default=0)

   def __str__(self):
      return self.stop_name + " " + self.stop_id

   