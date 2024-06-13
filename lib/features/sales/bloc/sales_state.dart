part of 'sales_bloc.dart';

@immutable
sealed class SalesState {}

final class SalesInitial extends SalesState {}
class SalesPdfGenerateLoading extends SalesState{}
class SalesPdfGenerateError extends SalesState{}
class SalesPdfGenerateSuccess extends SalesState{}