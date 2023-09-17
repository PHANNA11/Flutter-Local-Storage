class ProductModel {
  late int id;
  late String name;
  late double price;
  late String description;
  late String image;
  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
  });
  // Convert Object to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'image': image
    };
  }

  // Convert map to Object
  ProductModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        name = res['name'],
        price = res['price'],
        description = res['description'],
        image = res['image'];
}
