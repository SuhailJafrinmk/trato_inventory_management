part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}
class LogoutTilePressed extends ProfileEvent{}
class FetchStoreDetails extends ProfileEvent{}