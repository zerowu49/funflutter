import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final String text;
  final Function() onTap;
  IconData? icon;

  CalculatorButton({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.text,
    required this.onTap,
  });

  // ignore: non_constant_identifier_names
  CalculatorButton.Icon({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: backgroundColor,
        child: icon == null
            ? Center(
                child: Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: foregroundColor),
                ),
              )
            : Icon(
                icon,
                color: foregroundColor,
              ),
      ),
    );
  }
}
