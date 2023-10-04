from django.contrib import admin
from django.urls import path, include
from .views import PassengerDetailListView


app_name = "passengers"


urlpatterns = [
    path("passengers", PassengerDetailListView.as_view(), name="passenger-details")
]
