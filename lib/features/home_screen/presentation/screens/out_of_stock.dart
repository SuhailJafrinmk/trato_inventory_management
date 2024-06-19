import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:trato_inventory_management/features/home_screen/bloc/home_screen_bloc.dart';
import 'package:trato_inventory_management/features/product_details/presentation/product_details.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/widgets/product_tile.dart';

class OutOfStockItems extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Out of stock'),
      ),
      body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          if(state is HomeScreenDataSuccess){
            return ListView.builder(
              itemCount: state.stockOutItems.length,
              itemBuilder: (context,index){
                final data=state.stockOutItems[index];
                return ProductTile(productName: data['productName'], subtitle1: data['supplier'], subtitle2:" ${data['productQuantity']}", productImage: data['productImage'],onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetails(productData: data))),);
              });
          }
          return LoadingAnimationWidget.threeArchedCircle(color: AppColors.primaryColor, size: 30);
        },
      ),
    );
  }
}