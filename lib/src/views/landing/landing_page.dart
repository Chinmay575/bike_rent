import 'package:bike_rent/src/views/home/home_page.dart';
import 'package:bike_rent/src/views/landing/bloc/landing_bloc.dart';
import 'package:bike_rent/src/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<Widget> pages = [
    const HomePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LandingBloc, LandingState>(
        builder: (context, state) {
          return pages[state.index];
        },
      ),
      bottomNavigationBar: bottomAppBar(context),
    );
  }
}
