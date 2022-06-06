// Widget for item card in Checkout page

import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String? itemImage;
  final String? itemPrice;
  final String? itemName;
  ItemCard({
    this.itemImage,
    this.itemName,
    this.itemPrice,
  });

  // get getItemImage => itemImage;

  // final String? imageURL = getItemImage;

  // TODO: Remove shadow from card
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.white,
      child: Container(
        height: 100,
        color: Colors.white,
        child: Row(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Expanded(
                  child: Image.network(itemImage.toString()),
                  flex: 2,
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ListTile(
                        title: Text(itemName!),
                        subtitle: Text(itemPrice!),
                        // title: Text(
                        //     "Shape Of You Shape Of You Shape Of You Shape Of You"),
                        // subtitle: Text("Ed Sheeran"),
                      ),
                    ),
                  ],
                ),
              ),
              flex: 8,
            ),
          ],
        ),
      ),
      elevation: 8,
      margin: EdgeInsets.all(10),
    );
  }
}
