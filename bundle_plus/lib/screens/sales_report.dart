// Reference: https://www.youtube.com/watch?v=n1PM9XcYD5s = CRUD
// Reference2: https://stackoverflow.com/questions/50870652/flutter-firebase-basic-query-or-basic-search-code = Query from local list

import 'package:bundle_plus/model/item_model.dart';
import 'package:bundle_plus/model/order_model.dart';
import 'package:bundle_plus/screens/widgets/alt_item_card.dart';
import 'package:bundle_plus/screens/widgets/imagegrid.dart';
import 'package:bundle_plus/screens/widgets/item_card.dart';
import 'package:bundle_plus/services/auth_service.dart';
import 'package:bundle_plus/services/firestore_service.dart';
import 'package:bundle_plus/utils/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

class SalesReport extends StatefulWidget {
  const SalesReport({Key? key}) : super(key: key);

  @override
  State<SalesReport> createState() => _SalesReportState();
}

class _SalesReportState extends State<SalesReport> {
  // declaration of CollectionReference
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();
  final TextEditingController _orderStatusController = TextEditingController();
  List<Order> orders = [];
  List<ItemModel> itemList = [];

  // final Query<Object?> _orders = _firestoreService.orders
  //     .where('uid', isEqualTo: _authService.currentUser.uid);

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    _convertToList();
  }

  Future<void> _convertToList() async {
    print('init test');
    Future<List<Order>> _futureOrder = _firestoreService.retrieveOrderFuture();
    orders = await _futureOrder;
    print(orders[0].name);
    Future<List<ItemModel>> _futureItem =
        _firestoreService.retrieveItemFuture();
    itemList = await _futureItem;
    print(itemList[0].price);
    setState(() {}); // NOTE : will wait for the async to finish
  }

  @override
  Widget build(BuildContext context) {
    String searchKey = _authService.currentUser.uid;
    int pendingCount = 0;
    int deliveredCount = 0;
    double totalRevenue = 0.0;
    List<Order> orders_delivered = [];
    List<Order> orders_pending = [];
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Sales Report')),
        ),
        body: StreamBuilder(
          stream: _firestoreService.orders.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            // NOTE: avoid twice https://stackoverflow.com/questions/57562407/flutter-streambuilder-called-twice-when-initialized
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (streamSnapshot.hasError) {
              return Center(child: Text(streamSnapshot.error.toString()));
            } else if (streamSnapshot.connectionState ==
                ConnectionState.active) {
              //place your code here. It will prevent double data call.
              if (streamSnapshot.hasData && itemList != null) {
                // 1. Pending orders
                orders_pending = orders
                    .where(
                        (element) => element.sid?.contains(searchKey) ?? false)
                    .where((element) =>
                        element.status?.contains("Pending") ?? false)
                    .toList();

                // 2. Delivered orders
                orders_delivered = orders
                    .where(
                        (element) => element.sid?.contains(searchKey) ?? false)
                    .where((element) =>
                        element.status?.contains("Delivered") ?? false)
                    .toList();

                for (var element in orders_delivered) {
                  print("Delivered orders: " + element.name.toString());
                  deliveredCount += 1;
                }

                // 3. Total Revenue
                // List<ItemModel> delivered_items = itemList.where((element) => element.iid.contains(other))
                List<ItemModel> delivered_items = [];
                var itemDeliveredResults;
                for (var i in orders_delivered) {
                  print(i.name);
                  delivered_items += itemList
                      .where((element) =>
                          element.iid?.contains(i.iid.toString()) ?? false)
                      .toList();
                  // delivered_items.add(tempList)
                  print(delivered_items);
                }

                for (var i in delivered_items) {
                  totalRevenue += double.parse(i.price.toString());
                }
              }

              // orders = orders.w
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Expanded(
                  //   child:
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: ItemCard2(
                            title: 'Total Revenue',
                            subtitle: "RM " + totalRevenue.toString(),
                            color: const Color(0xFFFFBF37),
                            icon: Icons.attach_money,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Expanded(
                  // child:
                  Row(
                    // crossAxisCount: 2,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: ItemCard2(
                            title: 'Delivered Orders',
                            subtitle: orders_delivered.length.toString(),
                            color: const Color(0xFFFB777A),
                            icon: Icons.check_circle,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: ItemCard2(
                            title: 'Pending Orders',
                            subtitle: orders_pending.length.toString(),
                            color: const Color(0xFFA5A5A5),
                            icon: Icons.warning,
                          ),
                        ),
                      )
                    ],
                  ),

                  Text('data'),
                  Expanded(
                    child: ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.fromLTRB(7.0, 3, 7.0, 0),
                          child: ListTile(
                            // 3. Display  it
                            // MIGHT_DO: Add image to display
                            leading: FlutterLogo(),
                            title: Text(orders[index].name.toString()),
                            subtitle: Text(
                                "Date Created: " + orders[index].date.toString()
                                // "\nTime Created: " +
                                // orders[index].time.toString() +
                                // "\nStatus: " +
                                // orders[index].status.toString()
                                ),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [],
                              ),
                            ),
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
