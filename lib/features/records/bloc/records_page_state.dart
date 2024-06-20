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
  final List<Map<String,dynamic>> customerData;
  final List<Map<String,dynamic>> sellerData;

  FetchedCustomerAndSellerDetails({required this.customerData,required this.sellerData});
}