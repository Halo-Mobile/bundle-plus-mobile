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

  Future<void> createOrder(String name, String itemID, String sellerID) async {
    final Order _order = Order();

    //initializing the property of Order Model
    _order.name = name;
    _order.paymentMethod = "COD";
    _order.status = "pending";
    _order.date = DateFormat.yMMMd().format(DateTime.now());
    _order.time = DateFormat('hh:mm:ss').format(DateTime.now());
    _order.uid = _authService.currentUser.uid;
    _order.iid = itemID;
    _order.sid = sellerID;

    print(itemID);

    // storing the value to Firestore
    await _orders.add(_order.toMap());
  }
}
