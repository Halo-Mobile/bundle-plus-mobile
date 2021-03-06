// Reference: https://www.youtube.com/watch?v=n1PM9XcYD5s = CRUD
// Reference2: https://stackoverflow.com/questions/50870652/flutter-firebase-basic-query-or-basic-search-code = Query from local list

import 'package:bundle_plus/model/item_model.dart';
import 'package:bundle_plus/model/order_model.dart';
import 'package:bundle_plus/model/revenue_series.dart';
import 'package:bundle_plus/screens/widgets/alt_item_card.dart';
import 'package:bundle_plus/screens/widgets/dashboard_cards.dart';
import 'package:bundle_plus/screens/widgets/imagegrid.dart';
import 'package:bundle_plus/screens/widgets/item_card.dart';
import 'package:bundle_plus/screens/widgets/revenue_chart.dart';
import 'package:bundle_plus/services/auth_service.dart';
import 'package:bundle_plus/services/dashboard_service.dart';
import 'package:bundle_plus/services/firestore_service.dart';
import 'package:bundle_plus/utils/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SalesReport extends StatefulWidget {
  const SalesReport({Key? key}) : super(key: key);

  @override
  State<SalesReport> createState() => _SalesReportState();
}

class _SalesReportState extends State<SalesReport> {
  // declaration of CollectionReference
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();
  final DashboardService _dashboardService = DashboardService();
  final TextEditingController _orderStatusController = TextEditingController();
  List<Order> orders = [];
  List<ItemModel> itemList = [];
  List<RevenueSeries> data = [];
  int pendingCount = 0;
  int deliveredCount = 0;
  double totalRevenue = 0.0;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _initRetrieve();
  }

  Future<void> _initRetrieve() async {
    // print('init test');
    Future<int> _futurePendingCount = _dashboardService.getPendingCount();
    pendingCount = await _futurePendingCount;
    // print("_initRetrieve " + pendingCount.toString());

    Future<int> _futureDeliveredCount = _dashboardService.getDeliveredCount();
    deliveredCount = await _futureDeliveredCount;
    // print("_initRetrieve " + deliveredCount.toString());

    Future<double> _futureTotalRevenue = _dashboardService.getTotalRevenue();
    totalRevenue = await _futureTotalRevenue;

    Future<List<RevenueSeries>> _futureSeriesList =
        _dashboardService.initializeData();
    data = await _futureSeriesList;
    // print("_initRetrieve " + deliveredCount.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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

              // orders = orders.w
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Expanded(
                  //   child:
                  Container(
                    height: 380,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Total revenue by Category",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Expanded(
                              child: RevenueChart(
                                data: data,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // NOTE: Staggered Grid View for dashboard
                  Expanded(
                      child: StaggeredPage(
                    totalRevenue: totalRevenue,
                    completedOrders: deliveredCount,
                    pendingOrders: pendingCount,
                  )),
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
