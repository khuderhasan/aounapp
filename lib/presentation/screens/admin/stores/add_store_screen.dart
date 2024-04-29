import 'components/add_store_form.dart';
import 'package:flutter/material.dart';

import '../../../../config/constants.dart';
import '../../components/app_logo.dart';
import '../../components/background.dart';

class AddNewStoreScreen extends StatelessWidget {
  const AddNewStoreScreen({super.key});
  static const routeName = '/add_new_store_screen';
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
                'New Store',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Colors.black),
              ),
              const SizedBox(
                height: defaultPadding * 2,
              ),
              const Row(
                children: [
                  Spacer(),
                  Expanded(flex: 13, child: AddStoreForm()),
                  Spacer(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
