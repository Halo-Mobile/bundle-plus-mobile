class Order {
  String? uid;
  String? name;
  String? status;
  String? paymentMethod;
  String? time;
  String? date;

  Order({
    this.uid,
    this.name,
    this.status,
    this.paymentMethod,
    this.time,
    this.date,
  });

  // get data from server
  factory Order.fromMap(map) {
    return Order(
      uid: map['uid'],
      name: map['name'],
      status: map['status'],
      paymentMethod: map['paymentMethod'],
      time: map['time'],
      date: map['date'],
    );
  }

  // send data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'status': status,
      'paymentMethod': paymentMethod,
      'time': time,
      'date': date,
    };
  }
}
