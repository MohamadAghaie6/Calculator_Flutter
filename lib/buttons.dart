import 'package:flutter/material.dart';


class CustomButton extends StatefulWidget {
  const CustomButton({
    required this.color,
    required this.textcolor,
    required this.buttonText,
    super.key,
  });

  final Color color;
  final Color textcolor;
  final String buttonText;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 80,
          height: 80,
          color: widget.color,
          child: Center(
            child: Text(
              widget.buttonText,
              style: TextStyle(color: widget.textcolor, fontSize: 25),
            ),
          ),
        ),
      ),
    );
  }
}
