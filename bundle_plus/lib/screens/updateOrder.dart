import 'package:bundle_plus/screens/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(const UpdateOrder());

class UpdateOrder extends StatelessWidget {
  const UpdateOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
         backgroundColor: Color(0xfff8f8f8),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Update Order Status",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
        ),
      ),
        body: const Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);
  
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  late String dropdownValue = 'Pending';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.pinkAccent),
      underline: Container(
        height: 2,
        color: Colors.pinkAccent,
      ),
      onChanged: (String? newValue) async{
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Pending', 'Preparing Order', 'Delivered']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
