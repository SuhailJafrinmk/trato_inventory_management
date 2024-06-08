import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/inventory/bloc/inventory_bloc.dart';
import 'package:trato_inventory_management/utils/constants/image_links.dart';
import 'package:trato_inventory_management/widgets/product_tile.dart';

class CategoryProductPage extends StatefulWidget {
  final String CategoryName;

  CategoryProductPage({super.key, required this.CategoryName});

  @override
  State<CategoryProductPage> createState() => _CategoryProductPageState();
}

class _CategoryProductPageState extends State<CategoryProductPage> {
  User? user = FirebaseAuth.instance.currentUser;
  List<Map<String, dynamic>> categoryProducts = [];
  @override
  void initState() {
    BlocProvider.of<InventoryBloc>(context)
        .add(CategoryTileClicked(categoryName: widget.CategoryName));
        print(categoryProducts);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if (state is CategoryProductsFetched) {
          categoryProducts.addAll(state.categoryProducts);
        }
        if (state is CategoryProductsFetchingFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.CategoryName),
        ),
        body: BlocBuilder<InventoryBloc, InventoryState>(
          builder: (context, state) {
            if(state is CategoryProductsFetched){
              return ListView.builder(
                itemCount: state.categoryProducts.length,
                itemBuilder:(context,index){
                final product=state.categoryProducts[index];
                return ProductTile(
                  productName: product['productName'],
                 subtitle1: '${product['sellingPrice']}',
                  subtitle2: product['supplier'],
                   productImage: product['productImage']);
                } 
                );
            }
            if(state is CategoryProductsFetchingFailed){
              return Center(
                child: Text(state.message),
              );
            }
            if(state is CategoryProductsEmpty){
            return Center(
              child: Text('No Products available in this category'),
            );
            }
            return SizedBox();
          },
         
        ),




        // body: categoryProducts.isNotEmpty ?  ListView.builder(
        //         itemCount: categoryProducts.length,
        //         itemBuilder: (context, index) {
        //           print(categoryProducts);
        //           final item = categoryProducts[index];
        //           return ProductTile(
        //               productName: item['productName'],
        //               subtitle1: '${item['sellingPrice']}',
        //               subtitle2: item['supplier'],
        //               productImage: item['productImage']);
        //         }): Center(child: Text('No Products available for this category'),)
          
          
        
      ),
    );
  }
}
