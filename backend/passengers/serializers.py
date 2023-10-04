from rest_framework import serializers
from passengers.models import PassengerDetail


class PassengerDetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = PassengerDetail
        fields = "__all__"

        