import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color backgroundColor;

  const CalculatorButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0), // Set the border radius
        child: Container(
          alignment: Alignment.center,
          color: backgroundColor,
          child: text == '×' || text == '-'
              ? Text(
                  text,
                  style: const TextStyle(
                    fontSize: 45.0,
                    color: Colors.white,
                  ),
                )
              : Text(
                  text,
                  style: const TextStyle(
                    fontSize: 34.0,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
