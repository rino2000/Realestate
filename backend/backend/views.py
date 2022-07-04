from django.shortcuts import redirect, render
from django.urls import reverse_lazy
from django.views import View
from django.views.generic.list import ListView
from django.views.generic.edit import CreateView, UpdateView
from django.contrib.auth.views import LoginView, LogoutView
from django.views.generic.edit import DeleteView
from django.contrib import messages
from django.db.models import Sum
from django.db.models import FloatField
from django.db.models.functions import Cast

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
    success_message = "Successfully Logged in"

    def post(self, request, *args, **kwargs):
        messages.success(self.request, self.success_message, 'success')
        return super(Login, self).post(request, *args, **kwargs)


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
                return redirect('search', q=search)


class CreateHouse(View):
    template_name = 'create_house.html'

    def get(self, request):
        form = HouseForm()
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
                    city=form.cleaned_data['city'],
                    country=form.cleaned_data['country'],
                    plot_size=form.cleaned_data['plot_size'],
                )
                house.broker_id = self.request.user.id
                house.save()
                return redirect('dashboard')


class CreateBroker(CreateView):
    model = Broker
    form_class = BrokerForm
    template_name = 'create_broker.html'


class Dashboard(View):

    def get(self, request, *args, **kwargs):
        # get all houses from current logged broker
        houses = House.objects.filter(broker_id=self.request.user.id)

        # sum price of all houses from current broker
        value = House.objects.filter(
            broker_id=self.request.user.id).annotate(
                value=Cast('price', FloatField())
        ).aggregate(Sum('value'))

        chart = "test"

        # add plot to show all data
        return render(request, 'dashboard.html', context={
            'object_list': houses,
            'value': value.get('value__sum'),
            'chart': chart,
        })


class Profile(UpdateView):
    model = Broker
    template_name = 'profile.html'
    fields = ['name', 'email']

    # def get_queryset(self):
    #     return Broker.objects.filter(id=self.request.user.id)


class DeleteBroker(DeleteView):
    model = Broker
    success_url = reverse_lazy('home')
    template_name = 'delete_broker.html'


class DeleteHouse(DeleteView):
    model = House
    success_url = reverse_lazy('dashboard')
    template_name = 'delete_house.html'
