part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class OnTextChangedEvent extends HomeEvent {
  final String text;

  OnTextChangedEvent(this.text);
}

class OnClearTextEvent extends HomeEvent {}
