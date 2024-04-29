import '../components/app_logo.dart';
import '../components/background.dart';
import 'components/signup_form.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  static const routeName = '/signup_screen';

  @override
  Widget build(BuildContext context) {
    return const Background(
        child: SingleChildScrollView(
      child: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppLogoImage(),
          Row(
            children: [
              Spacer(),
              Expanded(
                flex: 10,
                child: SignUpForm(),
              ),
              Spacer()
            ],
          )
        ],
      )),
    ));
  }
}
