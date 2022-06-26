import 'package:flutter/material.dart';

const _defaultColor = Color(0xFF34568B);

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    Key? key,
    required this.title,
    this.topPadding = 0,
    required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: child,
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
    this.icondata,
    this.title,
    this.subtitle,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;
  final IconData? icondata;
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final child = Container(
        color: backgroundColor ?? _defaultColor,
        height: extent,
        child: Center(
          // child: CircleAvatar(
          //   minRadius: 20,
          //   maxRadius: 20,
          //   backgroundColor: Colors.white,
          //   // foregroundColor: Colors.black,
          //   child: Icon(icondata, color: Colors.black),
          // ),
          child: Align(
            alignment: Alignment.center,
            child: ListTile(
              leading: Icon(icondata, size: 50.0, color: Colors.white),
              title: Text(
                title.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                subtitle.toString(),
                style: TextStyle(color: Colors.white, fontSize: 14.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));

    final text = Text('data');

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        // Expanded(child: tex),
        Container(
          height: 20,
          color: Colors.green,
        )
      ],
    );
  }
}

class ImageTile extends StatelessWidget {
  const ImageTile({
    Key? key,
    required this.index,
    required this.width,
    required this.height,
  }) : super(key: key);

  final int index;
  final int width;
  final int height;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://picsum.photos/$width/$height?random=$index',
      width: width.toDouble(),
      height: height.toDouble(),
      fit: BoxFit.cover,
    );
  }
}

class InteractiveTile extends StatefulWidget {
  const InteractiveTile({
    Key? key,
    required this.index,
    this.extent,
    this.bottomSpace,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;

  @override
  _InteractiveTileState createState() => _InteractiveTileState();
}

class _InteractiveTileState extends State<InteractiveTile> {
  Color color = _defaultColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (color == _defaultColor) {
            color = Colors.red;
          } else {
            color = _defaultColor;
          }
        });
      },
      child: Tile(
        index: widget.index,
        extent: widget.extent,
        backgroundColor: color,
        bottomSpace: widget.bottomSpace,
      ),
    );
  }
}
