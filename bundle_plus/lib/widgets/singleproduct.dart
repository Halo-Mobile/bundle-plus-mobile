import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  final double price;
  final String name;
  SingleProduct({
    required this.image,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    String price2 = price.toStringAsFixed(2);
    return Card(
      child: Container(
        height: 270,
        width: 150,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Container(
                height: 190,
                width: 170,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/$image"),
                  ),
                ),
              ),
            ),
            Text(
              "RM ${price2.toString()}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.black),
            ),
            Text(
              name,
              style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
