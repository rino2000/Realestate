// ignore_for_file: non_constant_identifier_names, file_names

class Broker {
  int? id;
  String? name, email, password, telephone_number;

  Broker(
      {this.id, this.name, this.email, this.password, this.telephone_number});

  factory Broker.fromJson(Map<String, dynamic> json) {
    return Broker(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      password: json["password"],
      telephone_number: json["telephone_number"],
    );
  }

  @override
  String toString() {
    return "Broker($id, $name, $email, $password, $telephone_number)";
  }
}
