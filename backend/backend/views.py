from django.views.generic.list import ListView
from django.views.generic.edit import CreateView


from api.models import House, Broker


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


class CreateBroker(CreateView):
    model = Broker
    template_name = 'create_broker.html'
    fields = ['__all__']
