from django.shortcuts import render
from rest_framework.generics import ListAPIView
from vehicles.models import VehicleDetail
from vehicles.serializers import VehicleDetailSerializer


# Create your views here.
class VehicleDetailListView(ListAPIView):
    serializer_class = VehicleDetailSerializer
    queryset = VehicleDetail.objects.all()
