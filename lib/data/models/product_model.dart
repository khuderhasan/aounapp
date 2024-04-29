class ProductModel {
  final String? id;
  final String name;
  final double? price;
  final int amount;
  final String? location;
  final String? image;

  ProductModel(
      {this.id,
      required this.name,
      required this.price,
      required this.amount,
      required this.location,
      required this.image});

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      amount: json['amount'],
      location: json['location'],
      image: json['image']);

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'price': price,
        'amount': amount,
        'location': location,
        'image': image
      };
}
