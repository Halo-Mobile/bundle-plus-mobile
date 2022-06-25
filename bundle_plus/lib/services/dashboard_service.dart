// use this service for dashboard service

import 'package:bundle_plus/model/item_model.dart';
import 'package:bundle_plus/model/order_model.dart';
import 'package:bundle_plus/model/user_model.dart';
import 'package:bundle_plus/model/user_profile.dart';
import 'package:bundle_plus/services/auth_service.dart';
import 'package:bundle_plus/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardService {
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();
  List<Order> orderList = [];
  List<ItemModel> itemList = [];

  List<Order> orders_delivered = [];
  List<Order> orders_pending = [];
  late String searchKey = _authService.currentUser.uid;

  Future<void> _convertToList() async {
    // print('init test');
    Future<List<Order>> _futureOrder = _firestoreService.retrieveOrderFuture();
    orderList = await _futureOrder;
    // print(orderList[0].name);
    Future<List<ItemModel>> _futureItem =
        _firestoreService.retrieveItemFuture();
    itemList = await _futureItem;
    // print('_futureItem in convertTolist');

    // setState(() {}); // NOTE : will wait for the async to finish
  }

  Future<int> getPendingCount() async {
    // 1. Pending orders
    await _convertToList();
    orders_pending = orderList
        .where((element) => element.sid?.contains(searchKey) ?? false)
        .where((element) => element.status?.contains("Pending") ?? false)
        .toList();
    print('getPending count');

    return orders_pending.length;
  }

  Future<int> getDeliveredCount() async {
    // 2. Delivered orders
    await _convertToList();
    orders_delivered = orderList
        .where((element) => element.sid?.contains(searchKey) ?? false)
        .where((element) => element.status?.contains("Delivered") ?? false)
        .toList();
    print('getDelivered count');

    return orders_delivered.length;
  }

  Future<double> getTotalRevenue() async {
    double totalRevenue = 0.0;
    // 2. Delivered orders
    await _convertToList();
    orders_delivered = orderList
        .where((element) => element.sid?.contains(searchKey) ?? false)
        .where((element) => element.status?.contains("Delivered") ?? false)
        .toList();
    // print('getDelivered count');

    List<ItemModel> delivered_items = [];
    var itemDeliveredResults;
    print("order_delivered coyunt " + orders_delivered.length.toString());
    for (var i in orders_delivered) {
      print(i.name);
      delivered_items += itemList
          .where((element) => element.iid?.contains(i.iid.toString()) ?? false)
          .toList();
      // delivered_items.add(tempList)
      print(delivered_items);
    }

    for (var i in delivered_items) {
      totalRevenue += double.parse(i.price.toString());
    }

    return totalRevenue;
  }
}
