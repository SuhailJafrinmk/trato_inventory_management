import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:trato_inventory_management/models/product_model.dart';
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
    on<DeleteButtonClicked>(deleteButtonClicked);
  }

  //function just for adding the individual items into the list of purchase item just to be displayed on the ui.
  FutureOr<void> confirmQuantity(ConfirmQuantity event, Emitter<AddPurchaseState> emit) {
    itemsPurchased.add(event.purchasedItem);
    emit(SinglePurchaseAddedState(purcaseItems: itemsPurchased));
  }

  //function for adding a single purchase record including the list of items,date,total purchase amount to the database.
  FutureOr<void> addRecordConfirm(
      AddRecordConfirm event, Emitter<AddPurchaseState> emit) async {
    try {
      emit(PurchaseRecordAddLoading());
      CollectionReference reference = firestore
        .collection('UserData')
        .doc(user!.uid)
        .collection('PurchaseRecords');
      CollectionReference productReference=firestore.collection('UserData').doc(user!.uid).collection('Products');
      final formattedDate=DateFormat('yyyy-MM-dd – kk:mm').format(event.record.purchaseDate.toDate());
      await reference.doc(formattedDate).set(event.record.toMap());
      log('added purchase record to database');
      for(var item in event.record.items){
        DocumentReference productDoc=productReference.doc(item.productName);
        await firestore.runTransaction((transaction)async{
        DocumentSnapshot snapshot=await transaction.get(productDoc);
        if (!snapshot.exists) {
        throw Exception("Product does not exist!");
        }
        ProductModel product = ProductModel.fromMap(snapshot.data() as Map<String, dynamic>);
        log('quantity of product ${product.productQuantity}');
        product.productQuantity += item.quantity;

        transaction.update(productDoc, product.toMap());
        log('updated the product quantity');
        });
      }
      emit(PurchaseRecordAddSuccess());
      itemsPurchased.clear();
    } catch (e) {
      log('errorrrrr$e');
      emit(PurchaseRecordAddingError(message: e.toString()));
    }
  }

  FutureOr<void> deleteButtonClicked(DeleteButtonClicked event, Emitter<AddPurchaseState> emit) {
    itemsPurchased.remove(event.purchasedItem);
    emit(SinglePurchaseAddedState(purcaseItems: itemsPurchased));
  }
}
