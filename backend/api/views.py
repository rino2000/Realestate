from rest_framework import serializers, generics
from .models import House


class HouseSerializer(serializers.ModelSerializer):
    class Meta:
        model = House
        fields = '__all__'


class UserViewSet(generics.ListAPIView):
    queryset = House.objects.all()
    serializer_class = HouseSerializer
