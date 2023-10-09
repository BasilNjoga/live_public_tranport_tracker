from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path("admin/", admin.site.urls),
    path("auth/", include('rest_framework.urls')),
    path("passengers/", include("passengers.urls", namespace="passengers")),
    path("vehicles/",include("vehicles.urls", namespace="vehicles")),
    path("routes/", include("routes.urls", namespace="routes")),
]
