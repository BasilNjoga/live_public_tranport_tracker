from django.shortcuts import render
from rest_framework import generics
from passengers.models import PassengerDetail

from passengers.serializers import PassengerDetailSerializer


class PassengerDetailListView(generics.ListAPIView):
    serializer_class = PassengerDetailSerializer
    queryset = PassengerDetail.objects.all()

class SinglePassengerDetailListView(generics.RetrieveAPIView):
    serializer_class = PassengerDetailSerializer
    queryset = PassengerDetail.objects.all()


class CreateNewPassengerDetailView(generics.CreateAPIView):
    serializer_class = PassengerDetailSerializer
    queryset = PassengerDetail.objects.all()


class UpdatePassengerDetailView(generics.UpdateAPIView):
    serializer_class = PassengerDetailSerializer
    queryset = PassengerDetail.objects.all()

class DeletePassengerDetailView(generics.DestroyAPIView):
    serializer_class = PassengerDetailSerializer
    queryset = PassengerDetail.objects.all()
