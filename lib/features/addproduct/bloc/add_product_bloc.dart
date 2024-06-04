import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:trato_inventory_management/models/product_model.dart';
part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final ImagePicker imagePicker=ImagePicker();
  AddProductBloc() : super(AddProductInitial()) {
   on<DropdownTextfieldClicked>(dropdownTextfieldClicked);
   on<FetchCategoriesEvent>(fetchCategoriesEvent);
   on<AddProductButtonClicked>(addProductButtonClicked);
   on<AddImageButtonClicked>(addImageButtonClicked);
   on<FetchProducts>(fetchProducts);
  }

  FutureOr<void> dropdownTextfieldClicked(DropdownTextfieldClicked event, Emitter<AddProductState> emit) {
    emit(CategorySelectedState(newValue: event.selectedItem));
  }
  
  //fetches the categories required to show in the dropdown field for categories the event is called in init state of addproduct page
  FutureOr<void> fetchCategoriesEvent(FetchCategoriesEvent event, Emitter<AddProductState> emit)async{
    try{
      emit(CategoryLoadingState());
     FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? user = firebaseAuth.currentUser;
    CollectionReference categories = FirebaseFirestore.instance
        .collection('UserData')
        .doc(user!.uid)
        .collection('Category');
    QuerySnapshot querySnapshot = await categories.get();
      final dropDownItems=querySnapshot.docs.map((doc) =>doc.id).toList();
      emit(FetchingSuccessState(dropDownItems: dropDownItems));
    }catch(e){
      emit(FetchingFailedState(message: e.toString()));
    }
  }
  
  //function for submitting the form to firestore submits the entire data for the product including image
  FutureOr<void> addProductButtonClicked(AddProductButtonClicked event, Emitter<AddProductState> emit)async {
    try{
    emit(AddProductLoadingState());
    User ?currentUser=FirebaseAuth.instance.currentUser;
    FirebaseFirestore firestore=FirebaseFirestore.instance;
    String filename='images/${DateTime.now().millisecondsSinceEpoch}.png';
    Reference storage=FirebaseStorage.instance.ref().child(filename);
    await storage.putFile(File(event.productModel.productImage!.path));
    String imageUrl=await storage.getDownloadURL();
    ProductModel productModel=ProductModel(
      supplier: event.productModel.supplier,
      category: event.productModel.category,
      productName: event.productModel.productName,
      purchasePrice: event.productModel.purchasePrice,
      sellingPrice: event.productModel.sellingPrice,
      minimumQuantity: event.productModel.minimumQuantity,
      productImage: imageUrl,
      description: event.productModel.description
    );
    DocumentReference reference=firestore.collection('UserData').doc(currentUser!.uid);
    await reference.collection('Products').doc(event.productModel.productName).set(productModel.toMap());
    emit(ProductAddedSuccessState());
    }catch(e){
      emit(AddProductErrorState(message: e.toString()));
    }
  }
  
  //this function is just for picking the image and emit the state 
  FutureOr<void> addImageButtonClicked(AddImageButtonClicked event, Emitter<AddProductState> emit)async{
    final pickedImage=await imagePicker.pickImage(source: ImageSource.gallery);
    if(pickedImage!=null){
      emit(ImagePickedState(pickedImage: pickedImage));
    }
      }
  
  FutureOr<void> fetchProducts(FetchProducts event, Emitter<AddProductState> emit) {
    
  }
  }

