// Class for Admin Sidebar, use this under Scaffold to apply sidebar,
// Scaffold(
//   drawer: AdminSidebarDrawer(...),
//   ...
// )

import 'package:flutter/material.dart';

class AdminSidebarDrawer extends StatelessWidget {
  const AdminSidebarDrawer({Key? key}) : super(key: key);

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
            tileColor: Colors.grey[200],
            title: const Text('Edit Profile'),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const SellItems()));
            },
          ),
          SizedBox(
            height: 2,
          ),
          ListTile(
            tileColor: Colors.grey[200],
            title: const Text('Verify User'),
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
