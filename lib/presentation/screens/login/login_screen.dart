import '../components/app_logo.dart';
import '../components/background.dart';
import 'components/login_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const routeName = '/login_screen';

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
                    child: LoginForm(),
                  ),
                  Spacer()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
