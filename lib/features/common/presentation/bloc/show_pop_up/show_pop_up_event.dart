part of 'show_pop_up_bloc.dart';

@immutable
abstract class ShowPopUpEvent {}

class ShowPopUp extends ShowPopUpEvent {
  final String message;
  final bool isSuccess;
  ShowPopUp({required this.message, this.isSuccess = false});
}

class HidePopUp extends ShowPopUpEvent {}
