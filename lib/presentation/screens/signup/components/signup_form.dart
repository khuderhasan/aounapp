import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants.dart';
import '../../../../config/validators.dart';
import '../../../cubits/auth_cubit/auth_cubit.dart';
import '../../Login/login_screen.dart';
import '../../admin/stores/admin_stores_screen.dart';
import '../../components/all_ready_have_account.dart';
import '../../user/stores/user_stores_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formkey = GlobalKey<FormState>();
  String _firstName = '';
  String _email = '';
  String _password = '';
  String _lastName = '';
  bool _showPass = true;
  // ignore: unused_field
  String _confirmPassword = '';
  String? _accountType;

  Future<void> _trySubmit(BuildContext context) async {
    final isValid = _formkey.currentState!.validate();
    if (isValid) {
      _formkey.currentState!.save();
      await context.read<AuthCubit>().signUp(
          firstName: _firstName.trim(),
          email: _email.trim(),
          password: _password.trim(),
          lastName: _lastName.trim(),
          accountType: _accountType);
    }
  }

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
              builder: (context) => AlertDialog(
                    title: const Text(
                      'Error',
                      style: TextStyle(color: Colors.red),
                    ),
                    content: Text(state.error.message),
                  ));
        }
      },
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            //* Name TextField
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onSaved: (name) {
                  _firstName = name!;
                },
                validator: nameValidator,
                decoration: InputDecoration(
                  hintText: "First Name",
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Image.asset('assets/icons/name_icon.png'),
                  ),
                ),
              ),
            ),
            //*Last Name TextField
            TextFormField(
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (name) {
                _lastName = name!;
              },
              validator: nameValidator,
              decoration: InputDecoration(
                hintText: "Last Name",
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Image.asset('assets/icons/name_icon.png'),
                ),
              ),
            ),
            //* Email TextField
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                validator: emailValidator,
                onSaved: (email) {
                  _email = email!;
                },
                decoration: InputDecoration(
                  hintText: "Email",
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Image.asset('assets/icons/email_icon.png'),
                  ),
                ),
              ),
            ),
            //* Password TextField
            TextFormField(
              textInputAction: TextInputAction.done,
              validator: passwordValidator,
              onSaved: (password) {
                _password = password!;
              },
              obscureText: _showPass,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Password",
                suffixIcon: IconButton(
                  alignment: Alignment.center,
                  icon: Icon(
                      (_showPass) ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _showPass = !_showPass;
                    });
                  },
                ),
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Image.asset('assets/icons/pass_icon.png'),
                ),
              ),
            ),
            //* confirm password field
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(
                textInputAction: TextInputAction.done,
                validator: (value) {
                  confirmPasswordValidator(value, _password);
                  return;
                },
                onSaved: (confirmed) {
                  _confirmPassword = confirmed!;
                },
                obscureText: _showPass,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Confirm password",
                  suffixIcon: IconButton(
                    alignment: Alignment.center,
                    icon: Icon(
                        (_showPass) ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _showPass = !_showPass;
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
            DropdownButtonFormField<String>(
              hint: const Text('Account Type'),
              decoration: InputDecoration(
                hintText: "Your email",
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.account_box_sharp),
                ),
              ),
              validator: accountTypeValidator,
              onSaved: (accountType) {
                _accountType = accountType!;
              },
              items: accountTypeDropdownItems,
              onChanged: (value) {
                _accountType = value!;
              },
            ),

            const SizedBox(height: defaultPadding),
            ElevatedButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
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
                  return const Text("Create New Account");
                },
              ),
            ),
            const SizedBox(height: defaultPadding),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
