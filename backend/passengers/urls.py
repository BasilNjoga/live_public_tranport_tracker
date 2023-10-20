from django.contrib import admin
from django.urls import path, include
from .views import *


app_name = "passengers"


urlpatterns = [
    path("", PassengerDetailListView.as_view(), name="passenger-details"),
    path("<int:pk>/", SinglePassengerDetailListView.as_view(), name="specific-view"),
]
