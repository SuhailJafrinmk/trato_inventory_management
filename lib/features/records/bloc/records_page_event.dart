part of 'records_page_bloc.dart';

@immutable
sealed class RecordsPageEvent {}
class FetchSellerAndCustomerDetails extends RecordsPageEvent{}