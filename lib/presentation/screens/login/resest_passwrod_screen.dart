import '../components/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/constants.dart';
import '../../cubits/auth_cubit/auth_cubit.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});
  static const routeName = '/reset_password_screen';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _emailController = TextEditingController();
  Future<void> _resetpassword(BuildContext context) async {
    if (_emailController.text.isNotEmpty) {
      await context
          .read<AuthCubit>()
          .resetPassword(email: _emailController.text.trim());
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: BlocListener<AuthCubit, RegisterState>(
        listener: (context, state) {
          if (state is SuccessResetPassowrdState) {
            showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                      title: Text(
                        "Password Reset Success",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.green,
                        ),
                      ),
                      content: Padding(
                        padding: EdgeInsets.symmetric(vertical: defaultPadding),
                        child:
                            Text('Password reset link sent! Check your email'),
                      ),
                    ));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBar(
                title: const Text('Password Reset'),
                centerTitle: true,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: defaultPadding),
                child: Text(
                  'Please Enter your Email and We will send you a password reset link',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Your email",
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Image.asset('assets/icons/email_icon.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              MaterialButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  _resetpassword(context);
                },
                child: BlocBuilder<AuthCubit, RegisterState>(
                  builder: (context, state) {
                    if (state is LoadingRegisterState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return const Text(
                      'Reset Password',
                      style: TextStyle(
                        fontSize: 18,
                        color: kPrimaryColor,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
