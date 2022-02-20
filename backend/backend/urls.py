from django.contrib import admin
from django.urls import path

from .views import Data

from api.views import UserViewSet

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', Data.as_view()),
    path('api/data/', UserViewSet.as_view()),
]
