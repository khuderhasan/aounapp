import 'package:flutter/material.dart';

import '../../../../config/constants.dart';
import '../../../../data/models/product_model.dart';
import '../../components/app_logo.dart';
import '../../components/background.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});
  static const routeName = '/product_details_screen';
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Background(
        child: SingleChildScrollView(
      child: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppBar(
            leading: const BackButton(),
          ),
          const AppLogoImage(),
          const SizedBox(height: defaultPadding),
          const Text("Details", style: productDetailsTextStyle),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
            child: SizedBox(
              height: 150,
              width: 150,
              child: (product.image != null)
                  ? Image.network(product.image!)
                  : Container(),
            ),
          ),
          Text(
            product.name,
            style: productDetailsTextStyle,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
            child: Text(
              'Price: ${(product.price != null) ? product.price : "-"} ',
              style: productDetailsTextStyle,
            ),
          ),
          Text(
            'Location: ${product.location}',
            style: productDetailsTextStyle,
          ),
        ],
      )),
    ));
  }
}
