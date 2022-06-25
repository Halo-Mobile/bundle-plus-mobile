// Widget for item card in Checkout page

import 'package:flutter/material.dart';

class ItemCard2 extends StatelessWidget {
  final Color color;
  final IconData? icon;
  final String? title;
  final String? subtitle;
  ItemCard2({
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  // get getItemImage => itemImage;

  // final String? imageURL = getItemImage;

  // TODO: Remove shadow from card
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 10.0, right: 5.0, top: 20.0, bottom: 20.0),
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      shadowColor: Colors.white,
      color: color,
      child: Container(
          height: 100,
          // color: Colors.white,

          child: Align(
            alignment: Alignment.center,
            child: ListTile(
              leading: Icon(icon, size: 50.0, color: Colors.white),
              title: Text(
                title.toString(),
                style: TextStyle(color: Colors.white, fontSize: 14.0),
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                subtitle.toString(),
                style: TextStyle(color: Colors.white, fontSize: 14.0),
                textAlign: TextAlign.center,
              ),
            ),
            // child: IconButton(
            //   onPressed: (){
            //     getAlert(dashboardModel.totalProduct.toString(), 'Total Product Count');
            //   },
            //   icon: Icon(Icons.add_shopping_cart, size: 50.0, color: card1)
            // )
            // child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Expanded(
            //       flex: 8,
            //       child: Padding(
            //         padding: EdgeInsets.only(top: 30.0),
            //         child: Icon(Icons.add_shopping_cart,
            //             size: 30.0, color: Colors.white),
            //       ),
            //     ),
            //     Expanded(
            //       flex: 2,
            //       child: Text(
            //         'Total: ',
            //         // + dashboardModel.totalProduct.toString(),
            //         style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 14.0,
            //             fontWeight: FontWeight.bold),
            //         textAlign: TextAlign.center,
            //       ),
            //     ),
            //   ],
            // ),
          )),
      // margin: EdgeInsets.fromLTRB(20, 0, 0.0, 0),
    );
  }
}
