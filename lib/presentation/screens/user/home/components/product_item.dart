import 'package:flutter/material.dart';

import '../../../../../config/constants.dart';
import '../../../../../data/models/product_model.dart';
import '../../product/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            height: 150,
            width: 150,
            child: Column(
              children: [
                SizedBox(
                  width: 150,
                  height: 100,
                  child: Image.network(
                    product.image!,
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  product.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(30, 30)),
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 30, 55, 117)),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(product: product),
                ));
              },
              child: const Text('Show Details')),
        ))
      ],
    );
  }
}
