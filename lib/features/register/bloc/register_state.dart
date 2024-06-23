part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}
class RegisterLoadingState extends RegisterState{}
class RegisterErrorState extends RegisterState{
  final String errorMessage;

  RegisterErrorState({required this.errorMessage});

}
class RegisterSuccessState extends RegisterState{}
