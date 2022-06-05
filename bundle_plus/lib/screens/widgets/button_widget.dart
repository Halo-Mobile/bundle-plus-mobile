import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final String? textButton;
  final VoidCallback onPressed;
  const ButtonWidget({
    this.textButton,
    required this.onPressed,
  });

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: ElevatedButton(
            child: Text(widget.textButton.toString()),
            style: ElevatedButton.styleFrom(
              primary: Colors.pinkAccent,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            onPressed: widget.onPressed),
      ),
    );
  }
}
