// Class for Sidebar, usee this under Scaffold to apply sidebar,
// Scaffold(
//   drawer: SidebarDrawer(...),
//   ...
// )

import 'package:flutter/material.dart';

class SidebarDrawer extends StatelessWidget {
  const SidebarDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
            ),
            child: Text('Bundle+'),
          ),
          ListTile(
            title: const Text('Sell Item'),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const SellItems()));
            },
          ),
        ],
      ),
    );
  }
}
