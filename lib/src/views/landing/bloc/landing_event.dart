// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'landing_bloc.dart';

abstract class LandingEvent {}

class TabChange extends LandingEvent {
  int index;
  TabChange({
    required this.index,
  });
}
