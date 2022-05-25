class ItemModel {
  String? name;
  String? description;
  String? category;
  double? price;

  ItemModel({this.name, this.description, this.category, this.price});

  // get data from server
  factory ItemModel.fromMap(map) {
    return ItemModel(
      name: map['name'],
      description: map['description'],
      category: map['category'],
      price: map['price'],
    );
  }

  // send data to server
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'category': category,
      'price': price,
    };
  }
}
