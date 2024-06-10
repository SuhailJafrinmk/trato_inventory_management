part of 'add_sales_bloc.dart';

@immutable
sealed class AddSalesState {}

final class AddSalesInitial extends AddSalesState {}
class ItemQuanityAdded extends AddSalesState{
 final List<SelledItem>itemsAdded;

  ItemQuanityAdded({required this.itemsAdded});

}

class CustomerDetailsAddLoading extends AddSalesState{}
class CustomerDetalsAddSuccess extends AddSalesState{}
class CustomerDetailsAddError extends AddSalesState{
  final String message;
  CustomerDetailsAddError({required this.message});
}