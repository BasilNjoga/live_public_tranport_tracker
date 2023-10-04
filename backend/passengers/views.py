from django.shortcuts import render
from rest_framework.generics import ListAPIView
from passengers.models import PassengerDetail

from passengers.serializers import PassengerDetailSerializer


class PassengerDetailListView(ListAPIView):
    serializer_class = PassengerDetailSerializer
    queryset = PassengerDetail.objects.all()
