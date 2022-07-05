from django.contrib import admin
from django.urls import include, path
from django.conf import settings
from django.conf.urls.static import static

from api.views import UserViewSet
from .views import (CreateHouse,
                    CreateBroker,
                    Dashboard,
                    Login,
                    Logout,
                    Search,
                    Data,
                    Profile,
                    DeleteBroker,
                    DeleteHouse,
                    HouseView
                    )

urlpatterns = [
    path("__reload__/", include("django_browser_reload.urls")),
    path('admin/', admin.site.urls),
    path('', Data.as_view(), name='home'),
    path('search/<q>', Search.as_view(), name='search'),
    path('api/data/', UserViewSet.as_view()),
    path('login/', Login.as_view(), name='login'),
    path('logout/', Logout.as_view(), name='logout'),
    path('create/house/', CreateHouse.as_view(), name='createhouse'),
    path('dashboard/', Dashboard.as_view(), name='dashboard'),
    path('profile/<int:pk>', Profile.as_view(), name='profile'),
    path('create/broker/', CreateBroker.as_view(), name='createbroker'),
    path('broker/delete/<int:pk>', DeleteBroker.as_view(), name='deletebroker'),
    path('house/delete/<int:pk>', DeleteHouse.as_view(), name='deletehouse'),
    path('house/<slug:slug>', HouseView.as_view(), name='houseView'),
] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
