import '../../../../config/constants.dart';
import 'package:flutter/material.dart';

class FloatingAddButton extends StatelessWidget {
  const FloatingAddButton(
      {super.key, required this.title, required this.onPressed});
  final String title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(
            Icons.add,
            size: 35,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
                color: Color.fromARGB(255, 255, 102, 0),
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
