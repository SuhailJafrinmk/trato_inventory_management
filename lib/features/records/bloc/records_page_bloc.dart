import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'records_page_event.dart';
part 'records_page_state.dart';

class RecordsPageBloc extends Bloc<RecordsPageEvent, RecordsPageState> {
  final User? currentUser=FirebaseAuth.instance.currentUser;
  final firestore=FirebaseFirestore.instance;
  RecordsPageBloc() : super(RecordsPageInitial()) {
    on<FetchSellerAndCustomerDetails>(fetchSellerAndCustomerDetails);
  }

  FutureOr<void> fetchSellerAndCustomerDetails(FetchSellerAndCustomerDetails event, Emitter<RecordsPageState> emit)async {
    
    try{
      emit(FetchingCustomerAndSellerDetails());
      CollectionReference purchaseCollection=firestore.collection('UserData').doc(currentUser!.uid).collection('PurchaseRecords');
      CollectionReference salesCollection=firestore.collection('UserData').doc(currentUser!.uid).collection('SalesRecord');
      final purchaseSnapshot=await purchaseCollection.get();
      final salesSnapshot=await salesCollection.get();
      final purchaseDatas=purchaseSnapshot.docs.map((item) =>item.data() as Map<String,dynamic> ).toList();
      final salesDatas=salesSnapshot.docs.map((item) =>item.data() as Map<String,dynamic> ).toList();
      final purchaseLength=purchaseDatas.length;
      final salesLength=salesDatas.length;
      emit(FetchedCustomerAndSellerDetails(customers: purchaseLength, sellers: salesLength));
  }catch(e){
    emit(ErrorFetchingCustomerAndSellerDetail(message: e.toString()));
  }
}
}