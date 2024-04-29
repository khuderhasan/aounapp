import '../../components/background.dart';
import '../home/admin_home_screen.dart';

import '../../../cubits/stores/stores_cubit.dart';
import 'add_store_screen.dart';
import '../../components/store_widget.dart';

import '../components/add_new_product_button.dart';

import '../../signup/signup_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants.dart';
import '../../../cubits/auth_cubit/auth_cubit.dart';
import '../../components/app_logo.dart';

class AdminStoresScreen extends StatelessWidget {
  const AdminStoresScreen({super.key});
  static const routeName = '/admin_stores_screen';
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, RegisterState>(
      listener: (context, state) {
        if (state is SuccessSignOutRegisterState) {
          Navigator.of(context).pushReplacementNamed(SignUpScreen.routeName);
        }
      },
      child: Background(
        floatingActionButton: FloatingAddButton(
          title: "Add New Store",
          onPressed: () {
            Navigator.of(context).pushNamed(AddNewStoreScreen.routeName);
          },
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(actions: [
              IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                onPressed: () async {
                  context.read<AuthCubit>().signOut();
                },
              ),
            ]),
            const AppLogoImage(),
            const Text(
              'Available Stores',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  color: Colors.black),
            ),
            const SizedBox(height: defaultPadding * 2),
            Expanded(
              child: SingleChildScrollView(
                child: BlocBuilder<StoresCubit, StoresState>(
                  bloc: context.read<StoresCubit>()..getStores(),
                  builder: (context, state) {
                    if (state is LoadedStoresState) {
                      final stores = state.data;
                      if (stores.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding),
                          child: Column(
                            children: stores
                                .map((store) => StoreWidget(
                                      store: store,
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            AdminHomeScreen.routeName);
                                      },
                                    ))
                                .toList(),
                          ),
                        );
                      }
                      return const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: defaultPadding / 2),
                        child: Text(
                          'No Stores Yet !!',
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
