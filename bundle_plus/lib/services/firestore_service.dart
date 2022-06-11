// use this service for any firestore CRUD

import 'package:bundle_plus/model/order_model.dart';
import 'package:bundle_plus/model/user_model.dart';
import 'package:bundle_plus/model/user_profile.dart';
import 'package:bundle_plus/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FirestoreService {
  final AuthService _authService = AuthService();
  final CollectionReference _orders =
      FirebaseFirestore.instance.collection('orders');
  final CollectionReference _items =
      FirebaseFirestore.instance.collection('item');
  // final DocumentReference orders_doc_ref = _orders.do

  CollectionReference get orders => _orders;

  Future<void> createOrder(String name, String itemID, String sellerID) async {
    final Order _order = Order();
    // final docItem = FirebaseFirestore.instance.collection('orders').doc();

    // orders.get().then((value) => value.docs.forEach((element) {
    //       print(element.id);
    //     }));

    //initializing the property of Order Model
    _order.name = name;
    _order.paymentMethod = "COD";
    _order.status = "pending";
    _order.date = DateFormat.yMMMd().format(DateTime.now());
    _order.time = DateFormat('hh:mm:ss').format(DateTime.now());
    _order.uid = _authService.currentUser.uid;
    // _order.oid = orders.doc().id;
    _order.iid = itemID;
    _order.sid = sellerID;

    print(itemID);
    print(orders.doc('aYj9So1AEIgMibu6DnZs'));
    print(orders.doc().toString());

    // storing the value to Firestore
    await _orders.add(_order.toMap());
  }

  // TODO : Update Model instead of direct delete using firestore
  Future<void> deleteOrder(String id) async {
    await _orders.doc(id).delete();
  }

  Future<void> updateOrderStatus(String id, String newOrderStatus) async {
    await _orders.doc(id).update({"status": newOrderStatus});
  }

  Future<void> getItem(String id) async {}
}
