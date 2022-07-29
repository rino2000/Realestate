from rest_framework import serializers, generics
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated, AllowAny

from .models import Broker, House


class HouseSerializer(serializers.ModelSerializer):
    class Meta:
        model = House
        fields = '__all__'


class UserViewSet(generics.ListAPIView):
    queryset = House.objects.all()
    permission_classes = [AllowAny]
    serializer_class = HouseSerializer


class BrokerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Broker
        fields = '__all__'


class BrokerView(APIView):
    serializer_class = BrokerSerializer
    authentication_classes = [TokenAuthentication]
    # permission_classes = [IsAuthenticated]

    def get(self, request, *args, **kwargs):
        broker = Broker.objects.get(id=self.request.user.id)
        serializer = self.serializer_class(broker)
        return Response(serializer.data)
