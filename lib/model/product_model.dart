class ProductModel {
  late int id;
  late String name;
  late double price;
  ProductModel({
    required this.id,
    required this.name,
    required this.price,
  });
  // Convert Object to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }

  // Convert map to Object
  ProductModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        name = res['name'],
        price = res['price'];
}
