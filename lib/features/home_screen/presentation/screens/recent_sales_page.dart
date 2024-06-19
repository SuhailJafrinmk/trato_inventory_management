import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:trato_inventory_management/features/home_screen/bloc/home_screen_bloc.dart';
import 'package:trato_inventory_management/features/purchases/widgets/purchase_tile.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';

class RecentSalesPage extends StatelessWidget {
  const RecentSalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recent sales'),
      ),
      body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          if(state is HomeScreenDataSuccess){
          return ListView.builder(
            itemCount: state.recentSales.length,
              itemBuilder: (context,index){
                final data=state.recentSales[index];
                return PurchaseTile(records: data);
              }
              );
          }
          return LoadingAnimationWidget.threeArchedCircle(color: AppColors.primaryColor, size: 30);
        },
      ),
    );
  }
}