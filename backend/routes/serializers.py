from rest_framework import serializers
from routes.models import RouteDetail, StopDetail


class RouteDetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = RouteDetail
        fields = "__all__"


class StopDetailSerializer(serializers.ModelSerializer):

    class Meta:
        model = StopDetail
        fields = "__all__"
