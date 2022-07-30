// ignore_for_file: file_names

class Broker {
  BrokerData? brokerData;
  Value? value;
  int? totalHouses;

  Broker({this.brokerData, this.value, this.totalHouses});

  Broker.fromJson(Map<String, dynamic> json) {
    brokerData = json['broker_data'] != null
        ? BrokerData.fromJson(json['broker_data'])
        : null;
    value = json['value'] != null ? Value.fromJson(json['value']) : null;
    totalHouses = json['totalHouses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (brokerData != null) {
      data['broker_data'] = brokerData!.toJson();
    }
    if (value != null) {
      data['value'] = value!.toJson();
    }
    data['totalHouses'] = totalHouses;
    return data;
  }
}

class BrokerData {
  int? id;
  String? name, lastLogin, email, password, telephoneNumber, created;

  BrokerData(
      {this.id,
      this.lastLogin,
      this.name,
      this.email,
      this.password,
      this.telephoneNumber,
      this.created});

  BrokerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lastLogin = json['last_login'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    telephoneNumber = json['telephone_number'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['last_login'] = lastLogin;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['telephone_number'] = telephoneNumber;
    data['created'] = created;
    return data;
  }
}

class Value {
  double? valueSum;

  Value({this.valueSum});

  Value.fromJson(Map<String, dynamic> json) {
    valueSum = json['value__sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value__sum'] = valueSum;
    return data;
  }

  @override
  String toString() {
    return valueSum!.toStringAsFixed(2);
  }
}
