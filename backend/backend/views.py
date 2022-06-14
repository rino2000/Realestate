from django.shortcuts import redirect, render
from django.views import View
from django.views.generic.list import ListView
from django.views.generic.edit import CreateView
from django.contrib.auth.views import LoginView, LogoutView

from api.models import House, Broker
from api.Forms import BrokerForm, HouseForm
from api.Forms import SearchForm


class Search(View):

    def get(self, request, q, *args, **kwargs):
        model = House.objects.filter(city=q).order_by('-created')
        return render(request, 'search.html', context={'model': model})

    def post(self, request, *args, **kwargs):
        if request.method == 'POST':
            form = SearchForm(request.POST)
            if form.is_valid():
                search = form.cleaned_data['search']
                return redirect('search', q=search)


class Login(LoginView):
    template_name = 'login.html'


class Logout(LogoutView):
    next_page = 'home'


class Data(View):
    def get(self, request, *args, **kwargs):
        form = SearchForm()
        return render(request, 'index.html', context={'form': form})

    def post(self, request, *args, **kwargs):

        if request.method == 'POST':
            form = SearchForm(request.POST)
            if form.is_valid():
                search = form.cleaned_data['search']
                print(search)
                return redirect('search', q=search)


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
                    city=form.cleaned_data['city'],
                    country=form.cleaned_data['country'],
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


class Dashboard(ListView):
    model = House
    template_name = 'dashboard.html'

    def get_queryset(self):
        context = House.objects.filter(
            broker_id=self.request.user.id).order_by('-created')
        return context
