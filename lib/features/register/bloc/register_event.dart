part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}
class RegisterButtonClickedEvent extends RegisterEvent{
  final String userName;
  final String useEmail;
  final String password;

  RegisterButtonClickedEvent({required this.userName, required this.useEmail, required this.password});
}
class VisibilityIconClicked extends RegisterEvent{} 

