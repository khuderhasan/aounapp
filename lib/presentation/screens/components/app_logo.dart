import '../../../config/constants.dart';

import 'package:flutter/material.dart';

class AppLogoImage extends StatelessWidget {
  const AppLogoImage({super.key, this.headline});
  final String? headline;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: defaultPadding),
        Row(
          children: [
            const Spacer(),
            Image.asset("assets/images/logo1.png"),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
