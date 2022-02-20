// ignore_for_file: non_constant_identifier_names

class House {
  late String? title, price, plot, living_space, description, image;
  late int? bathrooms, bedrooms;

  House({
    required this.image,
    required this.title,
    required this.price,
    required this.plot,
    required this.living_space,
    required this.description,
    required this.bedrooms,
    required this.bathrooms,
  });

  factory House.fromJson(Map<String, dynamic> json) {
    return House(
      title: json['title'],
      price: json['price'],
      plot: json['plot'],
      living_space: json['living_space'],
      description: json['description'],
      image: json['image'],
      bathrooms: json['bathrooms'],
      bedrooms: json['bedrooms'],
    );
  }
}
