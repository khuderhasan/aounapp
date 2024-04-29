import '../../user/stores/user_stores_screen.dart';

import '../../admin/stores/admin_stores_screen.dart';

import '../resest_passwrod_screen.dart';

import '../../../cubits/auth_cubit/auth_cubit.dart';

import '../../../../config/constants.dart';
import '../../../../config/validators.dart';
import '../../components/all_ready_have_account.dart';
import '../../signup/signup_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formkey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  Future<void> _trySubmit(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final isValid = _formkey.currentState!.validate();
    if (isValid) {
      _formkey.currentState!.save();
      await context
          .read<AuthCubit>()
          .signIn(email: _email.trim(), password: _password.trim());
    }
  }

  bool _hidePass = true;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, RegisterState>(
      listener: (context, state) {
        if (state is SuccessRegisterState) {
          if (state.data.accountType == "user") {
            Navigator.of(context)
                .pushReplacementNamed(UserStoresScreen.routeName);
          } else if (state.data.accountType == "admin") {
            Navigator.of(context)
                .pushReplacementNamed(AdminStoresScreen.routeName);
          }
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar(reason: SnackBarClosedReason.hide)
            ..showSnackBar(const SnackBar(
              content: Text("Authenticated Successfully"),
              backgroundColor: Colors.green,
            ));
        } else if (state is ErrorRegisterState) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text(
                'Error',
                style: TextStyle(color: errorColor),
              ),
              content: Text(
                state.error.message,
                style: const TextStyle(fontSize: defaultPadding),
              ),
            ),
          );
        }
      },
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            //* Email TextField
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              validator: emailValidator,
              onSaved: (value) {
                _email = value!;
              },
              decoration: InputDecoration(
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: "Email",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Image.asset('assets/icons/email_icon.png'),
                ),
              ),
            ),
            //* Password TextField
            Padding(
              padding: const EdgeInsets.only(top: defaultPadding),
              child: TextFormField(
                textInputAction: TextInputAction.done,
                obscureText: _hidePass,
                validator: passwordValidator,
                onSaved: (value) {
                  _password = value!;
                },
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: IconButton(
                    alignment: Alignment.center,
                    icon: Icon(
                        (_hidePass) ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _hidePass = !_hidePass;
                      });
                    },
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Image.asset('assets/icons/pass_icon.png'),
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(ResetPasswordScreen.routeName);
                  },
                  child: const Text(
                    'Forgot Your Password?',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      // fontSize: 17,
                      decoration: TextDecoration.underline,
                    ),
                  )),
            ),

            const SizedBox(height: defaultPadding / 2),
            ElevatedButton(
              onPressed: () {
                _trySubmit(context);
              },
              child: BlocBuilder<AuthCubit, RegisterState>(
                bloc: context.read<AuthCubit>(),
                builder: (context, state) {
                  if (state is LoadingRegisterState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SuccessRegisterState) {
                    return const Center(
                      child: Icon(
                        Icons.done_outline_rounded,
                        color: Colors.green,
                      ),
                    );
                  }
                  return Text(
                    "Login".toUpperCase(),
                  );
                },
              ),
            ),
            const SizedBox(height: defaultPadding),
            AlreadyHaveAnAccountCheck(
              press: () async {
                Navigator.pushReplacementNamed(context, SignUpScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
