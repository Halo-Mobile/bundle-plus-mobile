class ItemModel {
  String? iid;
  String? name;
  String? description;
  String? category;
  String? price;
  String? image;
  String? condition;
  String? used;

  ItemModel(
      {this.iid,
      this.name,
      this.description,
      this.category,
      this.price,
      this.image,
      this.condition,
      this.used});

  // get data from server
  factory ItemModel.fromMap(map) {
    return ItemModel(
      iid: map['iid'],
      name: map['name'],
      description: map['description'],
      category: map['category'],
      price: map['price'],
      image: map['image'],
      condition: map['condition'],
      used: map['used'],
    );
  }

  // send data to server
  Map<String, dynamic> toMap() {
    return {
      'iid': iid,
      'name': name,
      'description': description,
      'category': category,
      'price': price,
      'image': image,
      'condition': condition,
      'used': used,
    };
  }
}
