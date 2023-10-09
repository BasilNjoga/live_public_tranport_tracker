from django.contrib import admin
from django.urls import path, include
from .views import VehicleDetailListView


app_name = "vehicles"


urlpatterns = [
    path("",VehicleDetailListView.as_view(), name="vehicle-details")
]
