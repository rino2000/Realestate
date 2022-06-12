from django.shortcuts import render
from django.views import View
from django.views.generic.list import ListView
from django.views.generic.edit import CreateView
from django.contrib.auth.views import LoginView, LogoutView

from api.models import House, Broker
from api.Forms import BrokerForm


class Login(LoginView):
    template_name = 'login.html'

class Logout(LogoutView):
    next_page = 'home'

class Data(ListView):
    model = House
    template_name = 'index.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        return context


class CreateHouse(CreateView):
    model = House
    template_name = 'create_house.html'
    # require image field
    fields = ['title', 'price', 'plot', 'bathrooms',
              'bedrooms', 'living_space', 'description']

    # def get_form_kwargs(self, **kwargs):
    #     house_id = super().get_context_data(**kwargs)
    #     house_id = kwargs.get('id')
    #     return house_id


class CreateBroker(CreateView):
    model = Broker
    form_class = BrokerForm
    template_name = 'create_broker.html'


class Dashboard(View):
    def get(self, request, *args, **kwargs):
        return render(request, 'dashboard.html')
