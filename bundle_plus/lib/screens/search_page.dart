import 'package:bundle_plus/screens/detailscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchPage extends SearchDelegate {
  CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection("items");

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(
          Icons.clear,
          // color: Colors.pinkAccent,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.pinkAccent,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firebaseFirestore.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data!.docs
                .where((QueryDocumentSnapshot<Object?> element) =>
                    element['name']
                        .toString()
                        .toLowerCase()
                        .replaceAll(' ', '')
                        .contains(query.toLowerCase().replaceAll(' ', '')))
                .isEmpty) {
              return Center(
                child: Text("No item \"" + query + "\" found"),
              );
            } else {
              return ListView(
                children: [
                  ...snapshot.data!.docs
                      .where((QueryDocumentSnapshot<Object?> element) =>
                          element['name']
                              .toString()
                              .toLowerCase()
                              .replaceAll(' ', '')
                              .contains(
                                  query.toLowerCase().replaceAll(' ', '')))
                      .map((QueryDocumentSnapshot<Object?> data) {
                    final String name = data.get('name');
                    final String image = data.get('image');
                    final String category = data.get('category');
                    final String iid = data.get('iid');
                    final String uid = data.get('uid');
                    final String price = data.get('price');
                    final String description = data.get('description');
                    final String used = data.get('used');
                    final String condition = data.get('condition');

                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                    iid: iid,
                                    uid: uid,
                                    image: image,
                                    name: name,
                                    price: price,
                                    description: description,
                                    condition: condition,
                                    used: used)));
                      },
                      title: Text(name),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(image ?? ""),
                      ),
                      subtitle: Text(category),
                    );
                  })
                ],
              );
            }
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text("Seach for items here (for example: baju)"));
  }
}
