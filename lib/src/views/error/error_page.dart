// ignore_for_file: must_be_immutable

import 'package:bike_rent/src/utils/contants.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  ErrorPage({super.key});
  late double deviceWidth;
  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        child: Center(
          child: Column(
            children: [
              const Text('Something went wrong!'),
              MaterialButton(
                height: 56,
                minWidth: deviceWidth * 0.5,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.landing);
                },
                child: const Text('Back to Home Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
