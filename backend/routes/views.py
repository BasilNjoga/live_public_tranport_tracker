from django.shortcuts import render
from rest_framework.generics import ListAPIView
from routes.models import RouteDetail, StopDetail
from routes.serializers import RouteDetailSerializer, StopDetailSerializer


# Create your views here.
class RouteDetailListView(ListAPIView):
    serializer_class = RouteDetailSerializer
    queryset = RouteDetail.objects.all()


class StopDetailListView(ListAPIView):
    serializer_class = StopDetailSerializer
    queryset = StopDetail.objects.all()
