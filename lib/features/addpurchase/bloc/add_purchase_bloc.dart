import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';
import 'package:trato_inventory_management/models/purchase_record_model.dart';
import 'package:trato_inventory_management/models/purchased_item.dart';

part 'add_purchase_event.dart';
part 'add_purchase_state.dart';

class AddPurchaseBloc extends Bloc<AddPurchaseEvent, AddPurchaseState> {
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<PurchasedItem> itemsPurchased = [];

  AddPurchaseBloc() : super(AddPurchaseInitial()) {
    on<ConfirmQuantity>(confirmQuantity);
    on<AddRecordConfirm>(addRecordConfirm);
  }

  //function just for adding the individual items into the list of purchase item just to be displayed on the ui.
  FutureOr<void> confirmQuantity(
      ConfirmQuantity event, Emitter<AddPurchaseState> emit) {
    itemsPurchased.add(event.purchasedItem);
    emit(SinglePurchaseAddedState(purcaseItems: itemsPurchased));
  }

  //function for adding a single purchase record including the list of items,date,total purchase amount.
  FutureOr<void> addRecordConfirm(
      AddRecordConfirm event, Emitter<AddPurchaseState> emit) async {
    try {
      emit(PurchaseRecordAddLoading());
      CollectionReference reference = firestore
          .collection('UserData')
          .doc(user!.uid)
          .collection('PurchaseRecords');
      await reference.add(event.record.toMap());
      emit(PurchaseRecordAddSuccess());
    } catch (e) {
      print(e.toString());
      emit(PurchaseRecordAddingError(message: e.toString()));
    }
  }
}
