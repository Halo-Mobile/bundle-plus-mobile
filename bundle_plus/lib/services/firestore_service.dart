// use this service for any firestore CRUD

import 'package:bundle_plus/model/item_model.dart';
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
      FirebaseFirestore.instance.collection('items');
  // final DocumentReference orders_doc_ref = _orders.do

  CollectionReference get orders => _orders;

  Future<void> createOrder(Order order) async {
    var docRef = _orders.doc();
    order.oid = docRef.id; // NOTE: setting the order id
    // storing the value to Firestore
    await docRef.set(order
        .toMap()); // NOTE: Somehow the order id will be same when using .set instead of .add
    // https://stackoverflow.com/questions/47474522/firestore-difference-between-set-and-add
  }

  Future<List<Order>> retrieveOrderFuture() async {
    final List<Order> orders = [];
    final snapshot = await _orders.get().then((document) {
      document.docs.forEach((element) {
        orders.add(Order.fromMap(element));
      });
    });

    return orders;
  }

  Future<List<ItemModel>> retrieveItemFuture() async {
    final List<ItemModel> items = [];
    final snapshot = await _items.get().then((document) {
      document.docs.forEach((element) {
        items.add(ItemModel.fromMap(element));
      });
    });

    return items;
  }

  // bad practice
  // Future<void> createOrder(String name, String itemID, String sellerID) async {
  //   final Order _order = Order();
  //   // final docItem = FirebaseFirestore.instance.collection('orders').doc();

  //   // orders.get().then((value) => value.docs.forEach((element) {
  //   //       print(element.id);
  //   //     }));

  //   //initializing the property of Order Model
  //   _order.name = name;
  //   _order.paymentMethod = "COD";
  //   _order.status = "pending";
  //   _order.date = DateFormat.yMMMd().format(DateTime.now());
  //   _order.time = DateFormat('hh:mm:ss').format(DateTime.now());
  //   _order.uid = _authService.currentUser.uid;
  //   // _order.oid = orders.doc().id;
  //   _order.iid = itemID;
  //   _order.sid = sellerID;

  //   print(itemID);
  //   print(orders.doc('aYj9So1AEIgMibu6DnZs'));
  //   print(orders.doc().toString());

  //   // storing the value to Firestore
  //   await _orders.add(_order.toMap());
  // }

  // TODO : Update Model instead of direct delete using firestore
  Future<void> deleteOrder(String id) async {
    await _orders.doc(id).delete();
  }

  Future<void> updateOrderStatus(String id, String newOrderStatus) async {
    await _orders.doc(id).update({"status": newOrderStatus});
  }

  Future<void> getItem(String id) async {}
}
