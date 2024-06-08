import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pdf/widgets.dart' as pw;

part 'purchase_event.dart';
part 'purchase_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  PurchaseBloc() : super(PurchaseInitial()) {
 on<PrintButtonClicked>(printButtonClicked);
  }

  FutureOr<void> printButtonClicked(PrintButtonClicked event, Emitter<PurchaseState> emit)async {
  final pdf = pw.Document();

  final file = File('example.pdf');
  await file.writeAsBytes(await pdf.save());
  }
}
