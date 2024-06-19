part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
class LogoutSuccess extends ProfileState{}
class LogoutError extends ProfileState{
  final String errorMessage;

  LogoutError({required this.errorMessage});
}
class LogoutLoading extends ProfileState{}
class FetchingStoreDetails extends ProfileState{}
class FetchedStoreDetails extends ProfileState{
    final Map<String,dynamic> data;

  FetchedStoreDetails({required this.data});
}
class FetchingStoreDetailsFailed extends ProfileState{
final String message;

  FetchingStoreDetailsFailed({required this.message});
}