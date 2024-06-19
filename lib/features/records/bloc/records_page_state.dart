part of 'records_page_bloc.dart';

@immutable
sealed class RecordsPageState {}

final class RecordsPageInitial extends RecordsPageState {}
class FetchingCustomerAndSellerDetails extends RecordsPageState{}
class ErrorFetchingCustomerAndSellerDetail extends RecordsPageState{
  final String message;

  ErrorFetchingCustomerAndSellerDetail({required this.message});
}
class FetchedCustomerAndSellerDetails extends RecordsPageState{
  final int customers;
  final int sellers;

  FetchedCustomerAndSellerDetails({required this.customers, required this.sellers});
}