part of 'home_screen_bloc.dart';

@immutable
sealed class HomeScreenState {}
final class HomeScreenInitial extends HomeScreenState {}


class HomeScreenDataLoading extends HomeScreenState{}
class HomeScreenDataError extends HomeScreenState{
  final String message;

  HomeScreenDataError({required this.message});

}
  class HomeScreenDataSuccess extends HomeScreenState{
    final Map<String,dynamic>dataToBeDisplayed;
    final List<Map<String,dynamic>> stockOutItems;
    final List<Map<String,dynamic>> recentSales;
    final List<Map<String,dynamic>> recentPurchases;

  HomeScreenDataSuccess({required this.dataToBeDisplayed, required this.stockOutItems,required this.recentSales,required this.recentPurchases});
  }