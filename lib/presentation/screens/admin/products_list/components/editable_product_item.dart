import '../../../../../providers/current_store_provider.dart';
import 'package:provider/provider.dart';

import '../../edit_product/edit_product_screen.dart';

import '../../../../cubits/products_cubit/products_cubit.dart';

import 'package:flutter/material.dart';

import '../../../../../data/models/product_model.dart';

class EditableProductItem extends StatelessWidget {
  const EditableProductItem({super.key, required this.product});
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(const Size(30, 30)),
                    backgroundColor: WidgetStateProperty.all(
                        const Color.fromARGB(255, 93, 134, 86)),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditProductScreen(product: product),
                    ));
                  },
                  child: const Text('Edit')),
              ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(const Size(30, 30)),
                    backgroundColor: WidgetStateProperty.all(Colors.red),
                  ),
                  onPressed: () async {
                    await context.read<ProductsCubit>().deleteProduct(
                          productId: product.id,
                          storeId: Provider.of<CurrentStoreProvider>(context,
                                  listen: false)
                              .currentStoreId,
                        );
                  },
                  child: const Text('Delete')),
            ],
          ),
        )
      ],
    );
  }
}
