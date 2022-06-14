from django import forms

from .models import Broker, House


class BrokerForm(forms.ModelForm):
    class Meta:
        model = Broker
        fields = ['name', 'email', 'password']

    def save(self, commit=True):
        broker = super().save(commit=False)
        broker.set_password(self.cleaned_data['password'])
        if commit:
            broker.save()
        return broker


class HouseForm(forms.ModelForm):
    class Meta:
        model = House
        fields = ['title', 'price', 'plot', 'bathrooms',
                  'bedrooms', 'living_space', 'plot_size', 'city', 'country', 'description']


class SearchForm(forms.Form):
    search = forms.CharField(label='Search for a city', max_length=50)
