// ignore_for_file: file_names, non_constant_identifier_names

class House {
  String? title,
      price,
      plot,
      bathrooms,
      bedrooms,
      living_space,
      plot_size,
      description,
      city,
      country,
      created,
      slug;
  int? id, broker_id;

  House({
    this.id,
    this.title,
    this.price,
    this.plot,
    this.bathrooms,
    this.bedrooms,
    this.living_space,
    this.plot_size,
    this.description,
    this.city,
    this.country,
    this.created,
    this.slug,
    this.broker_id,
  });

  factory House.fromJson(Map<String, dynamic> json) {
    return House(
      id: json["id"],
      title: json['title'],
      price: json['price'],
      plot: json['plot'],
      bathrooms: json['bathrooms'],
      bedrooms: json['bedrooms'],
      living_space: json['living_space'],
      plot_size: json['plot_size'],
      description: json['description'],
      city: json['city'],
      country: json['country'],
      created: json['created'],
      slug: json['slug'],
      broker_id: json['broker'],
    );
  }

  @override
  String toString() => 'House(broker_id: $broker_id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is House && other.broker_id == broker_id;
  }

  @override
  int get hashCode => broker_id.hashCode;
}
