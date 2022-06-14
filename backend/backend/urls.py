from django.contrib import admin
from django.urls import path

from .views import Data

from api.views import UserViewSet
from .views import CreateHouse, CreateBroker, Dashboard, Login, Logout, Search, Profile, DeleteBroker

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', Data.as_view(), name='home'),
    path('search/<q>', Search.as_view(), name='search'),
    path('api/data/', UserViewSet.as_view()),
    path('login/', Login.as_view(), name='login'),
    path('logout/', Logout.as_view(), name='logout'),
    path('create/house/', CreateHouse.as_view(),name='createhouse'),
    path('create/broker/', CreateBroker.as_view(),name='createbroker'),
    path('dashboard/', Dashboard.as_view(),name='dashboard'),
    path('profile/', Profile.as_view(),name='profile'),
    path('broker/delete/<int:pk>', DeleteBroker.as_view(),name='deletebroker'),
]
