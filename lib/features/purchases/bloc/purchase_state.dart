part of 'purchase_bloc.dart';

@immutable
sealed class PurchaseState {}

final class PurchaseInitial extends PurchaseState {}

class PdfGenerationLoading extends PurchaseState{}
class PdfGenerationSuccess extends PurchaseState{
  final String pdfPath;

  PdfGenerationSuccess({required this.pdfPath});
}
class PdfGenerationError extends PurchaseState{}
