class ItemModel {
  String? iid;
  String? name;
  String? description;
  String? category;
  String? condition;
  String? used;
  String? price;

  ItemModel({this.iid, this.name, this.description, this.category, this.condition, this.used, this.price});

  // get data from server
  factory ItemModel.fromMap(map) {
    return ItemModel(
      iid: map['iid'],
      name: map['name'],
      description: map['description'],
      category: map['category'],
      condition: map['condition'],
      used: map['used'],
      price: map['price'],
    );
  }

  // send data to server
  Map<String, dynamic> toMap() {
    return {
      'iid': iid,
      'name': name,
      'description': description,
      'category': category,
      'condition': condition,
      'used': used,
      'price': price,
    };
  }
}
