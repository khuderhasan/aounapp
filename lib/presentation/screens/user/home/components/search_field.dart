import 'package:flutter/material.dart';

import '../../../../../config/constants.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key, this.onChanged, this.onSubmitted});

  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.done,
      cursorColor: kPrimaryColor,
      decoration: InputDecoration(
        hintText: "Search Now...",
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Icon(Icons.search),
        ),
      ),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}
