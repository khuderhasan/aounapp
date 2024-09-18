import '../../../../data/datasources/stores_datasource.dart';
import '../../../../providers/current_store_provider.dart';
import 'package:provider/provider.dart';

import '../../signup/signup_screen.dart';

import '../all_products/all_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants.dart';
import '../../../cubits/auth_cubit/auth_cubit.dart';
import '../../../cubits/products_cubit/products_cubit.dart';
import '../../components/app_logo.dart';
import '../../components/background.dart';
import 'components/product_item.dart';
import 'components/search_field.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  static const routeName = '/user_home_screen';

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  Future<void> getStores() async {
    await StoresDatasource().getNearbyStores();
  }

  @override
  void initState() {
    getStores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, RegisterState>(
      listener: (context, state) {
        if (state is SuccessSignOutRegisterState) {
          Navigator.of(context).pushReplacementNamed(SignUpScreen.routeName);
        }
      },
      child: Background(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppBar(
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.red),
                      onPressed: () async {
                        context.read<AuthCubit>().signOut();
                      },
                    ),
                  ],
                ),
                const AppLogoImage(),
                BlocBuilder<AuthCubit, RegisterState>(
                  builder: (context, state) {
                    if (state is SuccessRegisterState) {
                      final headline = state.data.firstName;
                      return Column(
                        children: [
                          Text('Welcome $headline',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                  color: Colors.black)),
                          const SizedBox(height: defaultPadding * 2)
                        ],
                      );
                    }
                    return const SizedBox(height: defaultPadding * 2);
                  },
                ),
                Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 13,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: defaultPadding),
                            child: SearchField(
                              onSubmitted: (value) async {
                                await context
                                    .read<ProductsCubit>()
                                    .getProductsByName(
                                        productName: value.trim(),
                                        storeId:
                                            Provider.of<CurrentStoreProvider>(
                                                    context,
                                                    listen: false)
                                                .currentStoreId);
                              },
                            ),
                          ),
                          BlocBuilder<ProductsCubit, ProductsState>(
                            builder: (context, state) {
                              if (state is LoadedProductsByName) {
                                final products = state.data;
                                if (products.isNotEmpty) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    child: ListView.builder(
                                      itemBuilder: (context, index) =>
                                          ProductItem(
                                        product: products[index],
                                      ),
                                      itemCount: products.length,
                                    ),
                                  );
                                }
                                return const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: defaultPadding / 2),
                                  child: Text(
                                    'No Results !!',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                );
                              }

                              return Container();
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: defaultPadding),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(AllProductsScreen.routeName);
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                    const Color.fromARGB(255, 93, 134, 86)),
                                minimumSize: WidgetStateProperty.all(
                                  const Size(250, 50),
                                ),
                              ),
                              child: const Text('Brows Products'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
