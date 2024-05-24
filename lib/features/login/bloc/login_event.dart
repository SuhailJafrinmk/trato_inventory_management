part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}
class LoginButtonPressedEvent extends LoginEvent{
  final String userEmail;
  final String userPassword;
  LoginButtonPressedEvent({required this.userEmail, required this.userPassword});

}
