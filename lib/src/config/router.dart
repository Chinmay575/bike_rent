// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bike_rent/src/domain/models/route.dart';
import 'package:bike_rent/src/utils/contants.dart';
import 'package:bike_rent/src/views/checkout/bloc/checkout_bloc.dart';
import 'package:bike_rent/src/views/checkout/checkout_page.dart';
import 'package:bike_rent/src/views/details/bloc/details_bloc.dart';
import 'package:bike_rent/src/views/details/details_page.dart';
import 'package:bike_rent/src/views/error/error_page.dart';
import 'package:bike_rent/src/views/home/bloc/home_bloc.dart';
import 'package:bike_rent/src/views/home/home_page.dart';
import 'package:bike_rent/src/views/landing/bloc/landing_bloc.dart';
import 'package:bike_rent/src/views/landing/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static List<AppRoute> routes() => [
        AppRoute(
          route: AppRoutes.landing,
          view: const LandingPage(),
          bloc: BlocProvider(
            create: (context) => LandingBloc(),
          ),
        ),
        AppRoute(
          route: AppRoutes.home,
          view: const HomePage(),
          bloc: BlocProvider(
            create: (context) => HomeBloc(),
          ),
        ),
        AppRoute(
          route: AppRoutes.checkOut,
          view: const CheckoutPage(),
          bloc: BlocProvider(
            create: (context) => CheckoutBloc(),
          ),
        ),
        AppRoute(
          route: AppRoutes.details,
          view: const DetailsPage(),
          bloc: BlocProvider(
            create: (context) => DetailsBloc(),
          ),
        ),
      ];

  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    if (settings.name != null) {
      var results = routes().where((element) => element.route == settings.name);
      if (results.isNotEmpty) {
        return MaterialPageRoute(builder: (context) => results.first.view);
      }
    }
    return MaterialPageRoute(builder: (context) => ErrorPage());
  }

  static List<dynamic> allBlocProviders() {
    List blocProviders = [];
    for (var i in routes()) {
      blocProviders.add(i.bloc);
    }
    return blocProviders;
  }
}
