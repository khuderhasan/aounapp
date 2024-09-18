import '../../components/background.dart';
import '../add_new_product/add_product_screen.dart';

import '../components/add_new_product_button.dart';
import '../products_list/admin_products_list_screen.dart';

import '../../signup/signup_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants.dart';
import '../../../cubits/auth_cubit/auth_cubit.dart';
import '../../components/app_logo.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});
  static const routeName = '/admin_home_screen';
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
                title: "Add New Product",
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AddNewProductScreen.routeName);
                }),
            child: SingleChildScrollView(
                child: SafeArea(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                  AppBar(actions: [
                    IconButton(
                        icon: const Icon(Icons.logout, color: Colors.red),
                        onPressed: () async {
                          context.read<AuthCubit>().signOut();
                        })
                  ]),
                  const AppLogoImage(),
                  const Text('Welcome Admin',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Colors.black)),
                  const SizedBox(height: defaultPadding * 2),
                  Row(children: [
                    const Spacer(),
                    Expanded(
                        flex: 13,
                        child: Column(children: [
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: defaultPadding),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        AdminProductsListScreen.routeName);
                                  },
                                  style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
                                          const Color.fromARGB(
                                              255, 93, 134, 86)),
                                      minimumSize: WidgetStateProperty.all(
                                          const Size(250, 50))),
                                  child: const Text('View Products List')))
                        ])),
                    const Spacer()
                  ])
                ])))));
  }
}
