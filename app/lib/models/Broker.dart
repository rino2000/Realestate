// ignore_for_file: non_constant_identifier_names
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
    );
  }

  @override
  String toString() => 'Broker(id: $id, telephone_number: $telephone_number)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Broker &&
        other.id == id &&
        other.telephone_number == telephone_number;
  }

  @override
  int get hashCode => id.hashCode ^ telephone_number.hashCode;
}
