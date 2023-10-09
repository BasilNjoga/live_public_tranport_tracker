from rest_framework import serializers
from routes.models import RouteDetail


class RouteDetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = RouteDetail
        fields = "__all__"
