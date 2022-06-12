from django.contrib import admin
from django.urls import path
from django.contrib.auth.views import LogoutView

from .views import Data

from api.views import UserViewSet
from .views import CreateHouse, CreateBroker, Dashboard, Login, Logout

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', Data.as_view(), name='home'),
    path('api/data/', UserViewSet.as_view()),
    path('login/', Login.as_view(), name='login'),
    path('logout/', Logout.as_view(), name='logout'),
    path('create/house/', CreateHouse.as_view()),
    path('create/broker/', CreateBroker.as_view()),
    path('dashboard/', Dashboard.as_view()),
]
