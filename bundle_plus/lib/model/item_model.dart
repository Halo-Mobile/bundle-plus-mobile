class ItemModel {
  String? uid;
  String? iid;
  String? name;
  String? description;
  String? category;
  String? price;
  String? image;
  String? condition;
  String? used;

  ItemModel(
      {this.uid,
      this.iid,
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
      uid: map['uid'],
      iid: map['iid'],
      name: map['name'],
      description: map['description'],
      category: map['category'],
      condition: map['condition'],
      used: map['used'],
      price: map['price'],
      image: map['image'],
    );
  }

  // send data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'iid': iid,
      'name': name,
      'description': description,
      'category': category,
      'condition': condition,
      'used': used,
      'price': price,
      'image': image,
    };
  }
}
