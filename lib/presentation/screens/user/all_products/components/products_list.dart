import '../../../../../config/constants.dart';
import '../../../../../data/models/product_model.dart';
import '../../home/components/product_item.dart';
import '../../home/components/search_field.dart';
import 'package:flutter/material.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key, required this.products});
  final List<ProductModel> products;
  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  late List<ProductModel> showedProducts = widget.products;
  void _updateShowedProducts(String value) {
    setState(() {
      showedProducts = widget.products
          .where((product) =>
              product.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: SearchField(
              onChanged: (value) => _updateShowedProducts(value),
            ),
          ),
          (showedProducts.isNotEmpty)
              ? Column(
                  children: [
                    ...showedProducts
                        .map((product) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: defaultPadding / 2),
                              child: ProductItem(product: product),
                            ))
                        .toList()
                  ],
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: const Center(
                    child: Text('No Matching results'),
                  ),
                )
        ],
      ),
    );
  }
}
