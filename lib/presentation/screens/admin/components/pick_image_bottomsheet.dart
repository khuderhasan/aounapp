import 'package:flutter/material.dart';

import '../../../../config/constants.dart';

class PickImageBottomSheet extends StatelessWidget {
  const PickImageBottomSheet(
      {super.key, required this.cameraPressed, required this.galleryPressed});
  final void Function() cameraPressed;
  final void Function() galleryPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: defaultPadding),
            child: Text(
              'Pick Image From',
              style: productDetailsTextStyle,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                  onPressed: cameraPressed,
                  icon: const Icon(
                    Icons.camera,
                    size: 30,
                  ),
                  label: const Text('Camera')),
              TextButton.icon(
                  onPressed: galleryPressed,
                  icon: const Icon(
                    Icons.image,
                    size: 30,
                  ),
                  label: const Text('Gallery')),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: const ButtonStyle(
                fixedSize: WidgetStatePropertyAll(Size(100, 40)),
                backgroundColor: WidgetStatePropertyAll(
                  kPrimaryColor,
                ),
              ),
              child: const Text(
                'Ok',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
