// Class for Sidebar, usee this under Scaffold to apply sidebar,
// Scaffold(
//   drawer: SidebarDrawer(...),
//   ...
// )

import 'package:bundle_plus/screens/home.dart';
import 'package:bundle_plus/screens/order.dart';
import 'package:bundle_plus/screens/orderList.dart';
import 'package:bundle_plus/screens/sell_item.dart';
import 'package:bundle_plus/screens/sell_item_list.dart';
import 'package:flutter/material.dart';

class SidebarDrawer extends StatefulWidget {
  bool homeColor = true;
  bool sellColor = false;
  bool selllistColor = false;
  bool orderColor = false;
  String? firstName;
  String? secondName;
  String? email;
  VoidCallback? onPressed;
  SidebarDrawer({
    Key? key,
    required this.firstName,
    required this.secondName,
    required this.email,
    required this.onPressed,
  }) : super(key: key);

  @override
  _SidebarDrawerState createState() => _SidebarDrawerState();
}

class _SidebarDrawerState extends State<SidebarDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // child: ListView(
        // padding: EdgeInsets.zero,
        // children: <Widget>[
        //   // const DrawerHeader(
        //   //   decoration: BoxDecoration(
        //   //     color: Colors.pinkAccent,
        //   //   ),
        //   //   child: Text('Bundle+'),
        //   // ),
        //   UserAccountsDrawerHeader(
        //     currentAccountPicture: const CircleAvatar(
        //       backgroundImage: NetworkImage(
        //           "https://firebasestorage.googleapis.com/v0/b/bundleplus-91f36.appspot.com/o/profiles%2Favatar.png?alt=media&token=48fce17e-7708-44ab-b1fc-3bd6d389c0d9"),
        //     ),
        //     accountName: Text("${widget.firstName} ${widget.secondName}"),
        //     accountEmail: Text("${widget.email}"),
        //   ),
      //     ListTile(
      //       selected: widget.homeColor,
      //       enabled: true,
      //       leading: const Icon(Icons.home),
      //       title: const Text(
      //         'Home',
      //         style: TextStyle(fontWeight: FontWeight.bold),
      //       ),
      //       onTap: () {
      //         setState(() {
      //           widget.homeColor = true;
      //           widget.sellColor = false;
      //         });
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => const HomeScreen(),
      //           ),
      //         );
      //       },
      //     ),
      //     ListTile(
      //       selected: widget.sellColor,
      //       leading: const Icon(Icons.sell),
      //       title: const Text(
      //         'Sell Item',
      //         style: TextStyle(fontWeight: FontWeight.bold),
      //       ),
      //       onTap: () {
      //         setState(() {
      //           widget.homeColor = false;
      //           widget.sellColor = true;
      //         });
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => const SellItems(),
      //           ),
      //         );
      //       },
      //     ),
          // ListTile(
          //   leading: const Icon(Icons.logout_outlined),
          //   title: const Text(
          //     'Log Out',
          //     style: TextStyle(fontWeight: FontWeight.bold),
          //   ),
          //   onTap: widget.onPressed,
          // ),
      //   ],
      // ),
      child: ListView(
          // children: <Widget>[
            // const DrawerHeader(
            //   decoration: BoxDecoration(
            //     color: Colors.pinkAccent,
            //   ),
            //   child: Text('Bundle+'),
            // ),
            padding: EdgeInsets.zero,
            children: <Widget>[
              // const DrawerHeader(
              //   decoration: BoxDecoration(
              //     color: Colors.pinkAccent,
              //   ),
              //   child: Text('Bundle+'),
              // ),
              UserAccountsDrawerHeader(
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/bundleplus-91f36.appspot.com/o/profiles%2Favatar.png?alt=media&token=48fce17e-7708-44ab-b1fc-3bd6d389c0d9"),
                ),
                accountName: Text("${widget.firstName} ${widget.secondName}"),
                accountEmail: Text("${widget.email}"),
              ),
            ListTile(
              selected: widget.homeColor,
              enabled: true,
              leading: Icon(Icons.home),
              title: Text(
                'Home',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                setState(() {
                  widget.homeColor = true;
                  widget.sellColor = false;
                  widget.selllistColor = false;
                  widget.orderColor = false;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
            ),
            ListTile(
              selected: widget.sellColor,
              leading: Icon(Icons.sell),
              title: Text(
                'Sell Item',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                setState(() {
                  widget.homeColor = false;
                  widget.sellColor = true;
                  widget.selllistColor = false;
                  widget.orderColor = false;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SellItems(),
                  ),
                );
              },
            ),
            ListTile(
              selected: widget.selllistColor,
              leading: Icon(Icons.add_business_rounded),
              title: Text(
                'My Items',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                setState(() {
                  widget.homeColor = false;
                  widget.sellColor = false;
                  widget.selllistColor = true;
                  widget.orderColor = false;
                });
                 Navigator.of(
                        context)
                    .pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) =>
                        SellListScreen(
                      name:
                          "My Products",
                      snapShot:
                          snapShotList,
                      snapShotOrder: 
                        snapShotListId,
                      // ord:
                          // OrderItm,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              selected: widget.orderColor,
              leading: Icon(Icons.account_balance_wallet_rounded),
              title: Text(
                'My Orders',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                setState(() {
                  widget.homeColor = false;
                  widget.sellColor = false;
                  widget.selllistColor = false;
                  widget.orderColor = true;
                });
                 Navigator.of(
                        context)
                    .pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) =>
                        OrderListScreen(
                      name:
                          "My Orders",
                      snapShot:
                          snapShotOrder,
                      snapShotItem:
                          snapShotOrderID,
                    ),
                  ),
                );
              },
            ),
            ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text(
              'Log Out',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: widget.onPressed,
          ),
          ],
        // ),
      ),
    );
  }
}
