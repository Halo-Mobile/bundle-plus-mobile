import 'package:bundle_plus/screens/home.dart';
import 'package:bundle_plus/screens/search_page.dart';
import 'package:bundle_plus/screens/widgets/singleproduct.dart';
import 'package:flutter/material.dart';

import 'detailscreen.dart';

class ListProduct extends StatelessWidget {
  final String name;
  final AsyncSnapshot snapShot;
  ListProduct({required this.name, required this.snapShot});
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
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchPage(),
              );
            },
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
                            builder: (ctx) => DetailScreen(
                                iid: snapShot.data.docs[index]["iid"],
                                uid: snapShot.data.docs[index]["uid"],
                                image: "${snapShot.data.docs[index]["image"]}",
                                name: snapShot.data.docs[index]["name"],
                                price: snapShot.data.docs[index]["price"],
                                description: snapShot.data.docs[index]
                                    ["description"],
                                condition: snapShot.data.docs[index]
                                    ["condition"],
                                used: snapShot.data.docs[index]["used"]),
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
}
