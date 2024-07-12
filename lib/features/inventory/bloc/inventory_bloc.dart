import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:trato_inventory_management/models/category_model.dart';
import 'package:trato_inventory_management/models/purchase_record_model.dart';
part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
    final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    final FirebaseFirestore firestore=FirebaseFirestore.instance;    
  InventoryBloc() : super(InventoryInitial()) {
    on<AddCategoryButtonClicked>(addCategoryButtonClicked);
    on<CategoryTileLongpress>(categoryTileLongpress);
    on<FetchCategoriesEvent>(fetchCategoriesEvent);
    on<DeleteConfirmationClicked>(deleteConfirmationClicked);
    on<CategoryTileClicked>(categoryTileClicked);
  }
  
  //this block of code helps to add a new category the document will have the name of the category
  FutureOr<void> addCategoryButtonClicked(AddCategoryButtonClicked event, Emitter<InventoryState> emit)async{
    final currentuser=firebaseAuth.currentUser;
    try{
    emit(CategoryAddLoading());
    CollectionReference collectionReference=firestore.collection('UserData').doc(currentuser!.uid).collection('Category'); 
    await collectionReference.doc(event.categoryModel.category).set(event.categoryModel.toMap());
    emit(CategoryAddedSuccess());
    }catch(e){
      emit(CategoryAddedError(errorMessage: e.toString()));
    }
  }
 
 //meant for deleting an existing category 
  FutureOr<void> categoryTileLongpress(CategoryTileLongpress event, Emitter<InventoryState> emit) async{
    try{
    final currentuser=firebaseAuth.currentUser;
    CollectionReference collectionReference=firestore.collection('UserData').doc(currentuser!.uid).collection('Category'); 
    await collectionReference.doc(event.categoryName).delete();
    emit(CategoryDeleted());
    }catch(e){
      emit(CategoryDeletionError());
    }
    
  }

  //meant for fetching the existing available categories in order to validate a new category addition
  FutureOr<void> fetchCategoriesEvent(FetchCategoriesEvent event, Emitter<InventoryState> emit)async {
    final user=firebaseAuth.currentUser;
    CollectionReference reference=firestore.collection('UserData').doc(user!.uid).collection("Category");
    final documentObjects=await reference.get();
    final listOfDocuments=documentObjects.docs.map((doc) => doc.id).toList();
    emit(CategoriesFetchedState(listOfDocuments));
  }

   //for deleting a product from the collection of records
  FutureOr<void> deleteConfirmationClicked(DeleteConfirmationClicked event, Emitter<InventoryState> emit)async{
    emit(ProductDeletingLoadingState());
    try{
    final currentuser=firebaseAuth.currentUser;
    final deleteRefer=event.document;
    final toDelete=deleteRefer!['productName'];
     CollectionReference collectionReference=firestore.collection('UserData').doc(currentuser!.uid).collection('Products');
     await collectionReference.doc(toDelete).delete();
     emit(ProductDeletedSuccessState());
    }catch(e){
      print('error occured while deleting');
    }
  }
  
  //for fetching the products that includes in the clicked category
  FutureOr<void> categoryTileClicked(CategoryTileClicked event, Emitter<InventoryState> emit)async{
    try{
    final user=firebaseAuth.currentUser!.uid;
    CollectionReference collectionReference=firestore.collection('UserData').doc(user).collection('Products');
    final documents=await collectionReference.where('category',isEqualTo: event.categoryName).get();
    final allDocs=documents.docs.map((e) => e.data() as Map<String,dynamic>).toList();
    if(allDocs.isNotEmpty){
    emit(CategoryProductsFetched(categoryProducts: allDocs));
    }else{
      emit(CategoryProductsEmpty());
    }
    }catch(e){
      emit(CategoryProductsFetchingFailed(message: e.toString()));
    }
  }
}
