from django.contrib import admin
from django.urls import path

from .views import Data

from api.views import UserViewSet
from .views import CreateHouse, CreateBroker

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', Data.as_view(), name='home'),
    path('api/data/', UserViewSet.as_view()),
    path('create/house/', CreateHouse.as_view()),
    path('create/broker/', CreateBroker.as_view()),
]
