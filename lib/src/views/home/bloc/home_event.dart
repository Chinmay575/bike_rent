// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeEvent {}

class Initialize extends HomeEvent {}

class BookBike extends HomeEvent {
  Bike b;
  BookBike({
    required this.b,
  });
}
