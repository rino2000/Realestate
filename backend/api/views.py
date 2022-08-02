from rest_framework import serializers, generics
from rest_framework.views import APIView
from rest_framework.generics import DestroyAPIView
from rest_framework.response import Response
from rest_framework.authentication import TokenAuthentication
from rest_framework import status
from rest_framework.permissions import AllowAny, IsAuthenticated
from django.db.models.functions import Cast
from django.db.models import FloatField, Sum
from django.contrib.auth import logout

from .models import Broker, House


class HouseSerializer(serializers.ModelSerializer):
    class Meta:
        model = House
        exclude = ('image', 'slug')


class HouseViewSet(generics.ListAPIView):
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

    def get(self, request, *args, **kwargs):
        broker = Broker.objects.get(id=self.request.user.id)

        _ = House.objects.filter(broker_id=self.request.user.id)

        value = House.objects.filter(
            broker_id=self.request.user.id).annotate(
                value=Cast('price', FloatField())
        ).aggregate(Sum('value'))

        serializer = self.serializer_class(broker)
        totalHouses = _.count()

        context = {'broker_data': serializer.data,
                   'value': value, 'totalHouses': totalHouses}
        return Response(context)


class BrokerHouseList(APIView):
    serializer_class = HouseSerializer
    authentication_classes = [TokenAuthentication]

    # filter all houses by current broker
    def get(self, request, *args, **kwargs):
        houses = House.objects.filter(broker_id=self.request.user.id)
        serializer = self.serializer_class(houses, many=True)
        return Response(serializer.data)


class LogoutBrokerAPI(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, *args, **kwargs):
        self.request.user.auth_token.delete()
        logout(request)
        return Response('User successfully logged out')


class CreateHouseAPI(APIView):
    queryset = House.objects.all()
    serializer_class = HouseSerializer

    def post(self, request, format=None):
        serializer = HouseSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class DeleteBrokerAPI(DestroyAPIView):
    queryset = Broker.objects.all()
    serializer_class = BrokerSerializer
