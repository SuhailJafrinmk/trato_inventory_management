part of 'home_screen_bloc.dart';

@immutable
sealed class HomeScreenEvent {}

//this event is called on init state of homescreen
class FetchHomeScreenData extends HomeScreenEvent{}