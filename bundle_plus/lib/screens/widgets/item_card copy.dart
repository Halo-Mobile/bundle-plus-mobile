import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String? image;
  final String? price;
  final String? name;
  ItemCard({
    this.image,
    this.name,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(name!,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[600],
                )),
            const SizedBox(height: 6.0),
            Text(price!,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.red[800],
                )),
            const SizedBox(height: 6.0),
            // ElevatedButton.icon(
            //     onPressed: delete,
            //     label: Text('delete quote'),
            //     icon: Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
