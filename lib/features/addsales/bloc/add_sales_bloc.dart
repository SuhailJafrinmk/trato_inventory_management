import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:trato_inventory_management/models/sales_record_model.dart';
import 'package:trato_inventory_management/models/selled_item.dart';

part 'add_sales_event.dart';
part 'add_sales_state.dart';

class AddSalesBloc extends Bloc<AddSalesEvent, AddSalesState> {
  List<SelledItem>items=[];
  final firestore=FirebaseFirestore.instance;
  final user=FirebaseAuth.instance.currentUser;
  AddSalesBloc() : super(AddSalesInitial()) {
   on<ConfirmSingleSale>(confirmSingleSale);
   on<ConfirmCompleteSales>(confirmCompleteSales);
  }

  FutureOr<void> confirmSingleSale(ConfirmSingleSale event, Emitter<AddSalesState> emit) {
    items.add(event.selledItem);
    emit(ItemQuanityAdded(itemsAdded: items));
  }

  FutureOr<void> confirmCompleteSales(ConfirmCompleteSales event, Emitter<AddSalesState> emit)async {
    try {
      emit(CustomerDetailsAddLoading());
      CollectionReference reference = firestore
          .collection('UserData')
          .doc(user!.uid)
          .collection('SalesRecord');
      await reference.doc(event.salesRecordModel.saleDate).set(event.salesRecordModel.toMap());
      emit(CustomerDetalsAddSuccess());
    } catch (e) {
      print(e.toString());
      emit(CustomerDetailsAddError(message: e.toString()));
    }
  }
}
 