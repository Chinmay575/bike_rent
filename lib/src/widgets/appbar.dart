import 'package:bike_rent/src/views/landing/bloc/landing_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget bottomAppBar(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.width;
  return Container(
    height: 56,
    width: deviceWidth,
    decoration: const BoxDecoration(
      border: Border(
        top: BorderSide(
          color: Colors.grey,
        ),
      ),
    ),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          appBarItem(
            context,
            'assets/images/Home.png',
            'Home',
            0,
          ),
          appBarItem(
            context,
            'assets/images/Map Marker.png',
            'Maps',
            1,
          ),
          appBarItem(
            context,
            'assets/images/Card Wallet.png',
            'Wallet',
            2,
          ),
          appBarItem(
            context,
            'assets/images/Settings.png',
            'Setting',
            3,
          ),
        ],
      ),
    ),
  );
}

Widget appBarItem(
  BuildContext context,
  String asset,
  String text,
  int index,
) {
  return GestureDetector(
    onTap: () {
      BlocProvider.of<LandingBloc>(context).add(
        TabChange(index: index),
      );
    },
    child: SizedBox(
      height: 50,
      width: 50,
      child: Image.asset(asset),
    ),
  );
}

AppBar appBar(BuildContext context,String text) {
  return AppBar(
    leading: GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: const LinearGradient(
            colors: [
              Colors.grey,
              Colors.white,
            ],
          ),
        ),
        child: const Icon(Icons.arrow_back),
      ),
    ),
    title: Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(text),
      ),
    ),
  );
}
