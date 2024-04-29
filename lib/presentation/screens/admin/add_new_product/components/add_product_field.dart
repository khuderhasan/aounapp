import 'package:flutter/material.dart';

class NewProductField extends StatelessWidget {
  const NewProductField(
      {super.key,
      this.title,
      this.controller,
      this.onSaved,
      this.validator,
      this.keyboardType,
      this.initialValue});
  final String? title;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            title!,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: TextFormField(
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
            keyboardType: keyboardType!,
            controller: controller,
          ),
        )
      ],
    );
  }
}
