import 'package:bundle_plus/model/order_model.dart';
import 'package:bundle_plus/screens/home.dart';
import 'package:bundle_plus/screens/sell_item_detail.dart';
import 'package:bundle_plus/screens/widgets/singleproduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'detailscreen.dart';

class SellListScreen extends StatelessWidget {
  final String name;
  final AsyncSnapshot snapShot;

  // final Order ord;
  SellListScreen({required this.name, required this.snapShot});
  // SellListScreen({required this.name, required this.snapShot, required this.ord});
  var snapShotDetail;
  String? _uid;
  String? date;
  String? time;
  String? _paymentMethod;
  String? _status;
  Order orderModel = Order();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.pinkAccent,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => HomeScreen()),
              );
            }),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.pinkAccent),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: Colors.pinkAccent,
            ),
            onPressed: () {},
          ) // IconButton
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.pinkAccent),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 650,
                  child: GridView.builder(
                    itemCount: snapShot.data.docs.length,
                    itemBuilder: (ctx, index) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => SellItemDetail(
                              iid: "${snapShot.data.docs[index]["iid"]}",
                              image: "${snapShot.data.docs[index]["image"]}",
                              name: snapShot.data.docs[index]["name"],
                              price: snapShot.data.docs[index]["price"],
                              description: snapShot.data.docs[index]
                                  ["description"],
                              condition: snapShot.data.docs[index]["condition"],
                              used: snapShot.data.docs[index]["used"],
                              category: snapShot.data.docs[index]["category"],
                            ),
                          ),
                        );
                      },
                      child: SingleProduct(
                        name: snapShot.data.docs[index]["name"],
                        price: snapShot.data.docs[index]["price"],
                        image: snapShot.data.docs[index]["image"],
                      ),
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<Order> getModel(String itemID) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .where("iid", isEqualTo: itemID)
        .get()
        .then((value) {
      this.orderModel = Order.fromMap(value);
    });
    return orderModel;
  }
}
