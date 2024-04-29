import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({required this.child, this.floatingActionButton, super.key});
  final Widget child;
  final Widget? floatingActionButton;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                'assets/images/polygon1.png',
              ),
            ),
            Positioned(
              child: SafeArea(child: child),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                'assets/images/polygon2.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
