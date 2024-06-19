import 'dart:developer' as developer;
import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  List<Map<String,dynamic>>stockOutItems=[];
  List<Map<String,dynamic>>recentSales=[];
  HomeScreenBloc() : super(HomeScreenInitial()) {
  on<FetchHomeScreenData>(fetchHomeScreenData);
  }


//this function computes the total stock,total sales amount,total purchases,total products,total categores and also helps to sort out stock out items
  FutureOr<void> fetchHomeScreenData(FetchHomeScreenData event, Emitter<HomeScreenState> emit) async{
    try{
    emit(HomeScreenDataLoading());
    CollectionReference collectionReference=FirebaseFirestore.instance.collection('UserData').doc(userId).collection('SalesRecord');
    CollectionReference productCollection=FirebaseFirestore.instance.collection('UserData').doc(userId).collection('Products');
    CollectionReference categoryCollection=FirebaseFirestore.instance.collection('UserData').doc(userId).collection('Category');
    CollectionReference purchaseCollection=FirebaseFirestore.instance.collection('UserData').doc(userId).collection('PurchaseRecords');
    final snapshots=await collectionReference.get();
    final productSnapshots=await productCollection.get();
    final categorySnapshots=await categoryCollection.get();
    final purchaseSnapshots=await purchaseCollection.get();
    final recentSalesSnapshot=await collectionReference.orderBy('saleDate',descending: true).limit(10).get();
    double totalSaleAmount = 0.0;
    double totalStock = 0.0;
    double totalPurchases=0.0;
    int totalProducts=productSnapshots.docs.length;
    int totalCategories=categorySnapshots.docs.length;
    //for getting the recent ten sales
    recentSales.clear();
    for(var doc in recentSalesSnapshot.docs){
     final data=doc.data() as Map<String,dynamic>;
     stockOutItems.add(data);
    }
    //this block of code calculates the total amount of sales happened from all the documents of  salesrecord collection
  for(var doc in snapshots.docs){
    final  data=doc.data() as Map<String,dynamic>?;
    if (data != null) {
        totalSaleAmount += (data['totalAmount'] ?? 0.0).toDouble();
      }
  }
  //this block of code calculates the total price of the available stocks in the inventory
    for(var doc in productSnapshots.docs){
    final  data=doc.data() as Map<String,dynamic>?;
    if (data != null) {
        totalStock += (data['purchasePrice'] * data['productQuantity'] ?? 0.0).toDouble();
      }
  }
  //this block of code calculates the sub total of the purchases done to the shop
    for(var doc in purchaseSnapshots.docs){
    final  data=doc.data() as Map<String,dynamic>?;
    if (data != null) {
        totalPurchases += (data['totalAmount'] ?? 0.0).toDouble();
      }
  }
   //this block of code is for adding the stock out items in to a list
    stockOutItems.clear();
    for(var doc in productSnapshots.docs){
      final singleDoc= doc.data() as Map<String,dynamic>;
      if(singleDoc['productQuantity']==0){
        stockOutItems.add(singleDoc);
      }
    }
    
    //all data as passed as individual values except the stock out items as list
    emit(HomeScreenDataSuccess(dataToBeDisplayed: {
      'totalSaleAmount':totalSaleAmount,
      'totalStock':totalStock,
      'totalProducts':totalProducts,
      'totalCategories':totalCategories,
      'totalPurchases':totalPurchases,
      },
     stockOutItems: stockOutItems,
     recentSales: recentSales
     ));
    developer.log('items in the list$stockOutItems');

    }catch(e){
      emit(HomeScreenDataError(message: e.toString()));
    }
    
      }
}
