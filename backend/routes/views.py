from django.shortcuts import render
from rest_framework.generics import ListAPIView
from routes.models import RouteDetail
from routes.serializers import RouteDetailSerializer


# Create your views here.
class RouteDetailListView(ListAPIView):
    serializer_class = RouteDetailSerializer
    queryset = RouteDetail.objects.all()
