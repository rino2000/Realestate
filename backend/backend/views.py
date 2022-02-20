from django.views.generic.list import ListView


from api.models import House


class Data(ListView):
    model = House
    template_name = 'index.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        return context
