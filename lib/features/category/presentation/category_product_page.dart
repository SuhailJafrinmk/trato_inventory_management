import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/addproduct/presentation/add_product.dart';
import 'package:trato_inventory_management/features/inventory/bloc/inventory_bloc.dart';
import 'package:trato_inventory_management/features/product_details/presentation/product_details.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
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
    BlocProvider.of<InventoryBloc>(context).add(CategoryTileClicked(categoryName: widget.CategoryName));
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
          actions: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProduct(categoryName: widget.CategoryName,)));
            }, icon: Icon(Icons.add))
          ],
        ),
        body: BlocBuilder<InventoryBloc, InventoryState>(
          builder: (context, state) {
            if(state is CategoryProductsFetched){
              return ListView.builder(
                itemCount: state.categoryProducts.length,
                itemBuilder:(context,index){
                final product=state.categoryProducts[index];
                return ProductTile(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetails(productData: product),)),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                  DottedBorder(
                    color: Colors.black38,
                    borderType: BorderType.Circle,
                    child: IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProduct(categoryName: widget.CategoryName,)));
                    }, icon: Icon(Icons.add,size: 50,color: Colors.black38,))),
                    SizedBox(height: 10,),
                     Text('Add Product to this category',style: notImportant,),
                ],
              ),
            );
            }
            return SizedBox();
          },
         
        ),
          
        
      ),
    );
  }
}
