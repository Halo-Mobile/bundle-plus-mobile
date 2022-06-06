import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String? image;
  final String? price;
  final String? name;
  SingleProduct({
    this.image,
    this.name,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    // String? price2 = price.toStringAsFixed(2);
    return Card(
      child: Container(
        height: 220,
        width: 165,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Container(
                height: 120,
                width: 170,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("$image"),
                  ),
                ),
              ),
            ),
            Text(
              name!,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "RM $price",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.pinkAccent),
            ),
          ],
        ),
      ),
    );
  }
}
