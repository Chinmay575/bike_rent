// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'details_bloc.dart';

abstract class DetailsEvent {}

class DisplayDetails extends DetailsEvent {
  Bike bike;
  DisplayDetails({
    required this.bike,
  });
}

class AddRemoveExtraItems extends DetailsEvent {
  LoadedState prev;
  int index;
  String operation;
  AddRemoveExtraItems({
    required this.prev,
    required this.index,
    required this.operation,
  });
}
