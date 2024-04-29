import '../../../../data/models/product_model.dart';
import '../../components/background.dart';
import 'components/edit_product_form.dart';
import 'package:flutter/material.dart';

import '../../../../config/constants.dart';
import '../../components/app_logo.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key, required this.product});
  static const routeName = '/edit_product_screen';
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                leading: const BackButton(),
                forceMaterialTransparency: true,
              ),
              const AppLogoImage(),
              const Text(
                'Edit Product',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Colors.black),
              ),
              const SizedBox(
                height: defaultPadding * 2,
              ),
              Row(
                children: [
                  const Spacer(),
                  Expanded(flex: 13, child: EditProductForm(product: product)),
                  const Spacer(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
