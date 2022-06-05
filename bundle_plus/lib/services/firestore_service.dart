// database stuff

import 'package:bundle_plus/model/order_model.dart';
import 'package:bundle_plus/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FirestoreService {
  final FirebaseService _firebaseService = FirebaseService();
  final CollectionReference _orders =
      FirebaseFirestore.instance.collection('orders');

  Future<void> createOrder(String name) async {
    final Order _order = Order();

    //initializing the property of Order Model
    _order.name = name;
    _order.paymentMethod = "COD";
    _order.status = "pending";
    _order.date = DateFormat.yMMMd().format(DateTime.now());
    _order.time = DateFormat('hh:mm:ss').format(DateTime.now());
    _order.uid = _firebaseService.currentUser.uid;

    // storing the value to Firestore
    await _orders.add(_order.toMap());

    print('order created');
    print(_firebaseService.currentUser.uid);
    print(DateFormat('hh:mm:ss').format(DateTime.now()));
    print(DateFormat.yMMMd().format(DateTime.now()));
  }
}
