from django import forms

from .models import Broker


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
