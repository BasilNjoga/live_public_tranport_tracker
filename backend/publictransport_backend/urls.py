from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path("admin/", admin.site.urls),
    path("passengers/", include("passengers.urls", namespace="passengers")),
    path("vehicles/",include("vehicles.urls", namespace="vehicles")),
    path("routes/", include("routes.urls", namespace="routes")),
    path("users/", include("users.urls", namespace="users")),
    path("auth/", include("authtokens.urls", namespace="authtokens")),
]
