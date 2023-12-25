import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonAddPokemon extends StatelessWidget {
  void Function() onPressed;
  ButtonAddPokemon({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.withOpacity(0.1)),
        child: Center(
          child: Icon(
            Icons.add_circle_outline,
            color: Colors.grey.withOpacity(0.6),
            size: 50,
          ),
        ),
      ),
    );
  }
}
