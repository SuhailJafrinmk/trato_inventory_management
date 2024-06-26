part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
class LoginSuccessState extends LoginState{}
class LoginErrorState extends LoginState{
  final String message;

  LoginErrorState({required this.message});

}
class LoginLoadedState extends LoginState{}