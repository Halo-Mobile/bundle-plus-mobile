import 'package:bundle_plus/screens/home.dart';
import 'package:bundle_plus/widgets/singleproduct.dart';
import 'package:flutter/material.dart';

class ListProduct extends StatelessWidget {
  final String name;
  ListProduct({required this.name});
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
                                fontSize: 17, fontWeight: FontWeight.bold),
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
                  height: 850,
                  child: GridView.count(
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.78,
                    crossAxisCount: 2,
                    children: <Widget>[
                      SingleProduct(
                          image: "acer.jfif",
                          price: 3500,
                          name: "ACER Predator Helios 300"),
                      SingleProduct(
                          image: "ipx.jpg", price: 1500, name: "iPhone X"),
                      SingleProduct(
                          image: "dilo.jpg", price: 15, name: "Digital Logic"),
                      SingleProduct(
                          image: "oop.jpg",
                          price: 20.5,
                          name: "OOP using JAVA"),
                      SingleProduct(
                          image: "windbreaker.jpg",
                          price: 100,
                          name: "VTG ADIDAS WINDBREAKER"),
                      SingleProduct(
                          image: "backpack.jpg",
                          price: 355,
                          name: "Coach Backpack (F 59321)"),
                      SingleProduct(
                          image: "harddisck.jpg",
                          price: 150,
                          name:
                              "HGST 1TB sata 2.5 inch laptop hard disk external case"),
                      SingleProduct(
                          image: "sidemirror.jpg",
                          price: 30,
                          name: "Side Mirror SYM 125i SPORT RIDER"),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
