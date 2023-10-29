// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState {
  List<Bike> bikes;
  HomeState({
    required this.bikes,
  });

  HomeState copyWith({
    List<Bike>? bikes,
  }) {
    return HomeState(
      bikes: bikes ?? this.bikes,
    );
  }
}
