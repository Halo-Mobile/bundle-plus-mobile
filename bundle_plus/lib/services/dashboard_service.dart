// use this service for dashboard service

import 'package:bundle_plus/model/item_model.dart';
import 'package:bundle_plus/model/order_model.dart';
import 'package:bundle_plus/model/revenue_series.dart';
import 'package:bundle_plus/services/auth_service.dart';
import 'package:bundle_plus/services/firestore_service.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class DashboardService {
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();
  List<Order> orderList = [];
  List<ItemModel> itemList = [];

  List<Order> orders_delivered = [];
  List<Order> orders_pending = [];

  List<RevenueSeries> data = [];
  late String searchKey = _authService.currentUser.uid;

  Future<void> getModelList() async {
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
    await getModelList();
    orders_pending = orderList
        .where((element) => element.sid?.contains(searchKey) ?? false)
        .where((element) => element.status?.contains("Pending") ?? false)
        .toList();
    print('getPending count');

    return orders_pending.length;
  }

  Future<int> getDeliveredCount() async {
    // 2. Delivered orders
    await getModelList();
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
    await getModelList();
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

  // NOTE: intialize the data for Charts
  Future<List<RevenueSeries>> initializeData() async {
    // print('initializeData');

    double booksRevenue = 0.0;
    double electronicsRevenue = 0.0;
    double foodsRevenue = 0.0;
    double wearablesRevenue = 0.0;
    double equipmentRevenue = 0.0;
    await getModelList();
    // print('initializeData');
    orders_delivered = orderList
        .where((element) => element.sid?.contains(searchKey) ?? false)
        .where((element) => element.status?.contains("Delivered") ?? false)
        .toList();

    List<ItemModel> books = [];
    for (var i in orders_delivered) {
      print(i.name);
      books += itemList
          .where((element) => element.iid?.contains(i.iid.toString()) ?? false)
          .where((element) => element.category?.contains('Books') ?? false)
          .toList();
      // print(book);
    }
    for (var i in books) {
      booksRevenue += double.parse(i.price.toString());
    }

    List<ItemModel> electronics = [];
    for (var i in orders_delivered) {
      print(i.name);
      electronics += itemList
          .where((element) => element.iid?.contains(i.iid.toString()) ?? false)
          .where(
              (element) => element.category?.contains('Electronics') ?? false)
          .toList();
      // print(book);
    }
    for (var i in electronics) {
      electronicsRevenue += double.parse(i.price.toString());
    }
    // print("intializeData " +
    //     electronics[0].category.toString() +
    //     electronics[0].name.toString());

    List<ItemModel> foods = [];
    for (var i in orders_delivered) {
      print(i.name);
      foods += itemList
          .where((element) => element.iid?.contains(i.iid.toString()) ?? false)
          .where((element) => element.category?.contains('Foods') ?? false)
          .toList();
      // print(book);
    }
    for (var i in foods) {
      foodsRevenue += double.parse(i.price.toString());
    }
    List<ItemModel> wearables = [];
    for (var i in orders_delivered) {
      print(i.name);
      wearables += itemList
          .where((element) => element.iid?.contains(i.iid.toString()) ?? false)
          .where((element) => element.category?.contains('Wearables') ?? false)
          .toList();
      // print(book);
    }
    for (var i in wearables) {
      wearablesRevenue += double.parse(i.price.toString());
    }
    List<ItemModel> equipments = [];
    for (var i in orders_delivered) {
      print(i.name);
      equipments += itemList
          .where((element) => element.iid?.contains(i.iid.toString()) ?? false)
          .where((element) => element.category?.contains('Equipments') ?? false)
          .toList();
      // print(book);
    }
    for (var i in equipments) {
      equipmentRevenue += double.parse(i.price.toString());
    }

    data = [
      RevenueSeries(
          category: 'Books',
          revenue: booksRevenue,
          barColor: charts.ColorUtil.fromDartColor(Colors.green)),
      RevenueSeries(
          category: 'Electronics',
          revenue: electronicsRevenue,
          barColor: charts.ColorUtil.fromDartColor(Colors.green)),
      RevenueSeries(
          category: 'Foods',
          revenue: foodsRevenue,
          barColor: charts.ColorUtil.fromDartColor(Colors.green)),
      RevenueSeries(
          category: 'Wearables',
          revenue: wearablesRevenue,
          barColor: charts.ColorUtil.fromDartColor(Colors.green)),
      RevenueSeries(
          category: 'Equipments',
          revenue: equipmentRevenue,
          barColor: charts.ColorUtil.fromDartColor(Colors.green)),
    ];

    return data;
  }
}
