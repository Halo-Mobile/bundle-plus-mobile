class Order {
  String? oid;
  String? uid;
  String? iid;
  String? sid; //seller id
  String? name;
  String? status;
  String? paymentMethod;
  String? time;
  String? date;

  Order({
    this.oid,
    this.uid,
    this.iid,
    this.sid,
    this.name,
    this.status,
    this.paymentMethod,
    this.time,
    this.date,
  });

  // get data from server
  factory Order.fromMap(map) {
    return Order(
      oid: map['oid'],
      uid: map['uid'],
      iid: map['iid'],
      sid: map['sid'],      
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
      'oid': oid,
      'uid': uid,
      'iid': iid,
      'sid': sid,
      'name': name,
      'status': status,
      'paymentMethod': paymentMethod,
      'time': time,
      'date': date,
    };
  }
}
