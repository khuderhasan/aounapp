import 'user_map_screen.dart';

import '../home/user_home_screen.dart';

import '../../../cubits/stores/stores_cubit.dart';
import '../../components/store_widget.dart';
import '../../signup/signup_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants.dart';
import '../../../cubits/auth_cubit/auth_cubit.dart';
import '../../components/app_logo.dart';
import '../../components/background.dart';

class UserStoresScreen extends StatefulWidget {
  const UserStoresScreen({super.key});

  static const routeName = '/user_stores_screen';

  @override
  State<UserStoresScreen> createState() => _UserStoresScreenState();
}

class _UserStoresScreenState extends State<UserStoresScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, RegisterState>(
      listener: (context, state) {
        if (state is SuccessSignOutRegisterState) {
          Navigator.of(context).pushReplacementNamed(SignUpScreen.routeName);
        }
      },
      child: Background(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
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
              const Text(
                'Available Stores',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: defaultPadding * 2),
              Expanded(
                child: SingleChildScrollView(
                  child: BlocBuilder<StoresCubit, StoresState>(
                    bloc: context.read<StoresCubit>()..getNearbyStores(),
                    builder: (context, state) {
                      if (state is LoadedStoresState) {
                        final stores = state.data;
                        if (stores.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultPadding),
                            child: Column(
                              children: [
                                ...stores
                                    .map(
                                      (store) => StoreWidget(
                                        store: store,
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              UserHomeScreen.routeName);
                                        },
                                      ),
                                    )
                                    .toList(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: defaultPadding),
                                  child: TextButton.icon(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => MapScreen(
                                            stores: stores,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.map_outlined,
                                        size: 30, color: kPrimaryColor),
                                    label: const Text(
                                      "Show On Map",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: defaultPadding / 2),
                            child: Text('No Stores Yet !!',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)));
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
