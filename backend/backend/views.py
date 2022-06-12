from django.shortcuts import redirect, render
from django.views import View
from django.views.generic.list import ListView
from django.views.generic.edit import CreateView
from django.contrib.auth.views import LoginView, LogoutView
from django.views.generic.edit import FormView

from api.models import House, Broker
from api.Forms import BrokerForm, HouseForm


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


class CreateHouse(View):
    template_name = 'create_house.html'

    def get(self, request):
        form = HouseForm
        return render(request, 'create_house.html', context={'form': form})

    def post(self, request):

        if request.method == 'POST':

            form = HouseForm(request.POST)

            if form.is_valid():

                house = House.objects.create(
                    title=form.cleaned_data['title'],
                    price=form.cleaned_data['price'],
                    plot=form.cleaned_data['plot'],
                    bathrooms=form.cleaned_data['bathrooms'],
                    bedrooms=form.cleaned_data['bedrooms'],
                    living_space=form.cleaned_data['living_space'],
                    description=form.cleaned_data['description'],
                )
                house.broker_id = self.request.user.id
                house.save()

                return redirect('home')


class CreateBroker(CreateView):
    model = Broker
    form_class = BrokerForm
    template_name = 'create_broker.html'


class Dashboard(View):
    def get(self, request, *args, **kwargs):
        return render(request, 'dashboard.html')
