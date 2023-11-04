from django.contrib import admin
from django.urls import path, include
from .views import RouteDetailListView, StopDetailListView


app_name = "routes"


urlpatterns = [
    path("", RouteDetailListView.as_view(), name="route-details"),
    path("stops/", StopDetailListView.as_view(), name="stops")
]
