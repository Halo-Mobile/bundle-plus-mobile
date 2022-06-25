// Widget for item card in Checkout page

import 'package:flutter/material.dart';

class ItemCard2 extends StatelessWidget {
  final String? itemImage;
  final String? itemPrice;
  final String? itemName;
  ItemCard2({
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
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Expanded(
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
              // flex: 4,
            ),
          ],
        ),
      ),
      elevation: 1.0,
      // margin: EdgeInsets.fromLTRB(20, 0, 0.0, 0),
    );
  }
}
