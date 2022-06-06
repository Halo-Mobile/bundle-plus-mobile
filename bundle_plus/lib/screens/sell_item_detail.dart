import 'package:bundle_plus/screens/listproduct.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class SellItemDetail extends StatefulWidget {
  final String? image;
  final String? name;
  final String? price;
  final String? description;
  final String? condition;
  final String? used;
  SellItemDetail(
      {this.image,
      this.name,
      this.price,
      this.description,
      this.condition,
      this.used});
  @override
  State<SellItemDetail> createState() => _SellItemDetailState();
}

class _SellItemDetailState extends State<SellItemDetail> {
  Widget _buildSizeProduct({required String name}) {
    return Container(
      height: 60,
      width: 60,
      color: Colors.pinkAccent[100],
      child: Center(
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Order Detail",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.pinkAccent,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Center(
                  child: Container(
                    width: 350,
                    child: Card(
                      child: Container(
                        // color: Colors.pinkAccent[100],
                        padding: EdgeInsets.all(13),
                        child: Container(
                          height: 350,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              // fit: BoxFit.fill,
                              image: NetworkImage("${widget.image}"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 100,
                        child: Row(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${widget.name}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 0
                                      ..color = Colors.black,
                                  ),
                                ),
                                Text(
                                  "RM ${widget.price}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pinkAccent),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Description",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    // color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Wrap(
                          children: <Widget>[
                            Text(
                              "${widget.description}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Condition",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          // color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Wrap(
                          children: <Widget>[
                            Text(
                              "${widget.condition}/10",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Used For",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          // color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        // height: 70,
                        child: Wrap(
                          children: <Widget>[
                            Text(
                              "${widget.used}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Seller Name",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          // color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        // height: 70,
                        child: Wrap(
                          children: <Widget>[
                            Text(
                              "${widget.used}",
                              // change this into seller name
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Purchased Date",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          // color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        // height: 70,
                        child: Wrap(
                          children: <Widget>[
                            Text(
                              "${widget.used}",
                              //change to purchase date
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Order Status",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          // color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        // height: 70,
                        child: Wrap(
                          children: <Widget>[
                            Text(
                              "${widget.used}",
                              //change to order status
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   height: 60,
                      //   width: double.infinity,
                      //   child: ElevatedButton(
                      //     child: Text("Buy Now"),
                      //     style: ElevatedButton.styleFrom(
                      //       primary: Colors.pinkAccent,
                      //       onPrimary: Colors.white,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(15.0),
                      //       ),
                      //     ),
                      //     onPressed: () {},
                      //   ),
                      // ),
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
