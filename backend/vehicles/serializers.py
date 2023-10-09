from rest_framework import serializers
from vehicles.models import VehicleDetail


class VehicleDetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = VehicleDetail
        fields = "__all__"
