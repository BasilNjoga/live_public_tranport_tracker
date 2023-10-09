from django.contrib import admin
from django.urls import path, include
from .views import RouteDetailListView


app_name = "routes"


urlpatterns = [
    path("", RouteDetailListView.as_view(), name="route-details")
]
