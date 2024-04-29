import 'package:flutter/material.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function? press;
  const AlreadyHaveAnAccountCheck({
    super.key,
    this.login = true,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don’t have an Account ? " : "Already have an Account ? ",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: press as void Function()?,
          child: Text(
            login ? "Sign Up" : "Log In",
            style: const TextStyle(
              color: Color.fromARGB(255, 6, 79, 138),
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
