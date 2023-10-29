import 'package:bike_rent/src/views/checkout/bloc/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget button(
  BuildContext context,
  String text,
  void Function() onTap, {
  double width = 375,
  double height = 56,
}) {
  width = MediaQuery.of(context).size.width;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height,
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

Widget calenderButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      BlocProvider.of<CheckoutBloc>(context).add(
        PickDateRange(context: context),
      );
    },
    child: const Icon(
      Icons.calendar_month_outlined,
      size: 50,
    ),
  );
}
