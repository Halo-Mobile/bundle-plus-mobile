// Reference: https://www.youtube.com/watch?v=n1PM9XcYD5s = CRUD
// Reference2: https://stackoverflow.com/questions/50870652/flutter-firebase-basic-query-or-basic-search-code = Query from local list

import 'package:bundle_plus/model/order_model.dart';
import 'package:bundle_plus/services/auth_service.dart';
import 'package:bundle_plus/services/firestore_service.dart';
import 'package:bundle_plus/utils/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  // declaration of CollectionReference
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();
  final TextEditingController _orderStatusController = TextEditingController();
  List<Order> orders = [];
  List<Order> completedOrders = [];
  List<Order> pendingOrders = [];
  // final Query<Object?> _orders = _firestoreService.orders
  //     .where('uid', isEqualTo: _authService.currentUser.uid);

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    // _convertToList();
    _initRetrieve();
  }

  Future<void> _initRetrieve() async {
    Future<List<Order>> _futureOrderList =
        _firestoreService.retrieveOrderFuture();
    orders = await _futureOrderList;
    completedOrders = orders
        .where((element) =>
            element.uid?.contains(_authService.currentUser.uid) ?? false)
        .where((element) => element.status?.contains("Delivered") ?? false)
        .toList();
    pendingOrders = orders
        .where((element) =>
            element.uid?.contains(_authService.currentUser.uid) ?? false)
        .where((element) => element.status?.contains("Pending") ?? false)
        .toList();
    // print("_initRetrieve " + deliveredCount.toString());
    setState(() {});
  }

// TODO: cleanup code
  @override
  Widget build(BuildContext context) {
    String searchKey = _authService.currentUser.uid;
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('My Orders')),
        ),
        body: StreamBuilder(
          stream: _firestoreService.orders.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              // 2. Query the list of orders

              // DEBUG : to see whether the query is working
              for (var element in orders) {
                print("Elements printed here belongs to user: " +
                    _authService.currentUser.email.toString());
                print(element.date);
              }

              // orders = orders.w
              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Pending Orders',
                    style: AppTheme.headline2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: pendingOrders.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            // 3. Display  it
                            // MIGHT_DO: Add image to display
                            title: Text(pendingOrders[index].name.toString()),
                            subtitle: Text("Date Created: " +
                                pendingOrders[index].date.toString() +
                                "\nTime Created: " +
                                pendingOrders[index].time.toString() +
                                "\nStatus: " +
                                pendingOrders[index].status.toString()),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () async {
                                        OneContext()
                                            .showModalBottomSheet<String>(
                                                builder: (context) => Container(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Text(
                                                            'Change Order Status',
                                                            style: AppTheme
                                                                .headline2,
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          ListTile(
                                                              leading: Icon(
                                                                  Icons.cancel),
                                                              title: Text(
                                                                  'Cancel Order'),
                                                              onTap: () async {
                                                                await _firestoreService
                                                                    .updateOrderStatus(
                                                                        orders[index]
                                                                            .oid
                                                                            .toString(),
                                                                        "Cancel");
                                                                await OneContext()
                                                                    .showDialog(
                                                                        builder: (_) =>
                                                                            AlertDialog(title: Text("Order " + orders[index].name.toString() + " cancelled!"), content: const Text("You have cancelled your order"), actions: <Widget>[
                                                                              TextButton(child: const Text("OK"), onPressed: () => OneContext().popDialog('ok')),
                                                                            ]));
                                                              }),
                                                          ListTile(
                                                              leading: Icon(Icons
                                                                  .thumb_up),
                                                              title: Text(
                                                                  'Order Received'),
                                                              onTap: () async {
                                                                await _firestoreService.updateOrderStatus(
                                                                    orders[index]
                                                                        .oid
                                                                        .toString(),
                                                                    "Delivered");
                                                                await OneContext()
                                                                    .showDialog(
                                                                        builder: (_) =>
                                                                            AlertDialog(title: Text("Order " + orders[index].name.toString() + " successfully received!"), content: const Text("Your order has been successfully received."), actions: <Widget>[
                                                                              TextButton(child: const Text("OK"), onPressed: () => OneContext().popDialog('ok')),
                                                                            ]));
                                                              }),
                                                          SizedBox(height: 45)
                                                        ],
                                                      ),
                                                    ));
                                      }),
                                  IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () async {
                                        // NOTE: Not a cancel function
                                        // TODO : Add another confirmation dialog before deleting.

                                        // print(streamSnapshot.data!.docs[index].id);
                                        await _firestoreService.deleteOrder(
                                            orders[index].oid.toString());

                                        if (OneContext.hasContext) {
                                          // copy this to show dialog
                                          await OneContext().showDialog(
                                              builder: (_) => AlertDialog(
                                                      title: Text("Order " +
                                                          orders[index]
                                                              .name
                                                              .toString() +
                                                          " successfully deleted!"),
                                                      content: const Text(
                                                          "Your order has been successfully deleted."),
                                                      actions: <Widget>[
                                                        TextButton(
                                                            child: const Text(
                                                                "OK"),
                                                            onPressed: () =>
                                                                OneContext()
                                                                    .popDialog(
                                                                        'ok')),
                                                      ]));
                                        }
                                      }),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Completed Orders',
                    style: AppTheme.headline2,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: completedOrders.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            // 3. Display  it
                            // MIGHT_DO: Add image to display
                            title: Text(completedOrders[index].name.toString()),
                            subtitle: Text("Date Created: " +
                                completedOrders[index].date.toString() +
                                "\nTime Created: " +
                                completedOrders[index].time.toString() +
                                "\nStatus: " +
                                completedOrders[index].status.toString()),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
// Add new product

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
