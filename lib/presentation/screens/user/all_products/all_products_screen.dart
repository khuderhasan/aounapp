import 'package:provider/provider.dart';

import '../../../../providers/current_store_provider.dart';
import 'components/products_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants.dart';
import '../../../cubits/products_cubit/products_cubit.dart';
import '../../components/app_logo.dart';
import '../../components/background.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});
  static const routeName = '/all_products_screen';
  @override
  Widget build(BuildContext context) {
    return Background(
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
              'Products List',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  color: Colors.black),
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
                          .currentStoreId,
                    ),
                  builder: (context, state) {
                    if (state is LoadedAllProducts) {
                      final products = state.data;
                      if (products.isNotEmpty) {
                        return ProductsList(
                          products: products,
                        );
                      }
                      return const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: defaultPadding / 2),
                        child: Text(
                          'No Products !!',
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
      ),
    );
  }
}
