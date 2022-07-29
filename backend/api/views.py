from rest_framework import serializers, generics
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import AllowAny
from django.db.models.functions import Cast
from django.db.models import FloatField, Sum

from .models import Broker, House


class HouseSerializer(serializers.ModelSerializer):
    class Meta:
        model = House
        fields = '__all__'


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

        # return Response({serializer.data, value, totalHouses})

        context = {'broker_data': serializer.data,
                   'value': value, 'totalHouses': totalHouses}
        print(context)
        return Response(context)


class BrokerHouseList(APIView):
    serializer_class = HouseSerializer
    authentication_classes = [TokenAuthentication]

    # filter all houses by current broker
    def get(self, request, *args, **kwargs):
        houses = House.objects.filter(broker_id=self.request.user.id)
        serializer = self.serializer_class(houses, many=True)
        return Response(serializer.data)
