import '../add_new_product/add_product_screen.dart';
import '../../../../providers/current_store_provider.dart';
import 'package:provider/provider.dart';

import '../components/add_new_product_button.dart';
import 'components/editable_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants.dart';
import '../../../cubits/products_cubit/products_cubit.dart';
import '../../components/app_logo.dart';
import '../../components/background.dart';

class AdminProductsListScreen extends StatelessWidget {
  const AdminProductsListScreen({super.key});
  static const routeName = '/admin_products_list_screen';
  @override
  Widget build(BuildContext context) {
    return Background(
      floatingActionButton: FloatingAddButton(
        title: "Add New Product",
        onPressed: () {
          Navigator.of(context).pushNamed(AddNewProductScreen.routeName);
        },
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            leading: const BackButton(),
            forceMaterialTransparency: true,
          ),
          const AppLogoImage(),
          const Text(
            'Products List',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 23, color: Colors.black),
          ),
          const SizedBox(
            height: defaultPadding * 2,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: BlocBuilder<ProductsCubit, ProductsState>(
                bloc: context.read<ProductsCubit>()
                  ..getAllProducts(
                      storeId: Provider.of<CurrentStoreProvider>(context,
                              listen: false)
                          .currentStoreId),
                builder: (context, state) {
                  if (state is LoadedAllProducts) {
                    final products = state.data;
                    if (products.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        child: Column(
                          children: products
                              .map((product) => EditableProductItem(
                                    product: product,
                                  ))
                              .toList(),
                        ),
                      );
                    }
                    return const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: defaultPadding / 2),
                      child: Text(
                        'No Prodcuts !!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
