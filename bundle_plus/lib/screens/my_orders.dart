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
  // final Query<Object?> _orders = _firestoreService.orders
  //     .where('uid', isEqualTo: _authService.currentUser.uid);

  @override
  Widget build(BuildContext context) {
    String searchKey = _authService.currentUser.uid;
    Stream streamQuery;
    var snapshot = _firestoreService.orders
        .where('uid', isEqualTo: _authService.currentUser.uid);
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('My Orders')),
        ),
        body: StreamBuilder(
          stream: _firestoreService.orders.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              // 1. First, store data from firebase to a local list
              // MIGHT_DO: Would be nice to sort this based on date time

              List<Order> orders = streamSnapshot.data!.docs
                  .map((doc) => Order(
                        // oid: doc['oid'], // not found to get Order_id use this  streamSnapshot.data!.docs[index].id under itemBuilder
                        uid: doc['uid'],
                        iid: doc['iid'],
                        sid: doc['sid'],
                        name: doc['name'],
                        status: doc['status'],
                        paymentMethod: doc['paymentMethod'],
                        time: doc['time'],
                        date: doc['date'],
                      ))
                  .toList();

              // 2. Query the list of orders
              orders = orders
                  .where((element) => element.uid?.contains(searchKey) ?? false)
                  .toList();

              // orders = orders.w
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      // 3. Display  it
                      // MIGHT_DO: Add image to display
                      title: Text(orders[index].name.toString()),
                      subtitle: Text("Date Created: " +
                          orders[index].date.toString() +
                          "\nTime Created: " +
                          orders[index].time.toString() +
                          "\nStatus: " +
                          orders[index].status.toString()),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () async {
                                  OneContext().showModalBottomSheet<String>(
                                      builder: (context) => Container(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  'Change Order Status',
                                                  style: AppTheme.headline2,
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                ListTile(
                                                    leading: Icon(Icons.cancel),
                                                    title: Text('Cancel Order'),
                                                    onTap: () async {
                                                      await _firestoreService
                                                          .updateOrderStatus(
                                                              streamSnapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id,
                                                              "Cancel");
                                                      await OneContext()
                                                          .showDialog(
                                                              builder: (_) =>
                                                                  AlertDialog(
                                                                      title: Text("Order " +
                                                                          orders[index]
                                                                              .name
                                                                              .toString() +
                                                                          " cancelled!"),
                                                                      content:
                                                                          const Text(
                                                                              "You have cancelled your order"),
                                                                      actions: <
                                                                          Widget>[
                                                                        TextButton(
                                                                            child:
                                                                                const Text("OK"),
                                                                            onPressed: () => OneContext().popDialog('ok')),
                                                                      ]));
                                                    }),
                                                ListTile(
                                                    leading:
                                                        Icon(Icons.thumb_up),
                                                    title:
                                                        Text('Order Received'),
                                                    onTap: () async {
                                                      await _firestoreService
                                                          .updateOrderStatus(
                                                              streamSnapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id,
                                                              "Delivered");
                                                      await OneContext()
                                                          .showDialog(
                                                              builder: (_) =>
                                                                  AlertDialog(
                                                                      title: Text("Order " +
                                                                          orders[index]
                                                                              .name
                                                                              .toString() +
                                                                          " successfully received!"),
                                                                      content:
                                                                          const Text(
                                                                              "Your order has been successfully received."),
                                                                      actions: <
                                                                          Widget>[
                                                                        TextButton(
                                                                            child:
                                                                                const Text("OK"),
                                                                            onPressed: () => OneContext().popDialog('ok')),
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
                                      streamSnapshot.data!.docs[index].id);

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
                                                      child: const Text("OK"),
                                                      onPressed: () =>
                                                          OneContext()
                                                              .popDialog('ok')),
                                                ]));
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                  );
                },
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
