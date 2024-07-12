import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:trato_inventory_management/features/home_screen/bloc/home_screen_bloc.dart';
import 'package:trato_inventory_management/features/purchases/widgets/purchase_tile.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';

class RecentPurchases extends StatelessWidget {
  const RecentPurchases({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recent Purchases'),
      ),
      body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          if(state is HomeScreenDataSuccess){
            if(state.recentPurchases.isEmpty){
              return const Center(
                child: Text('There is no recent purchases to display'),
              );
            }
          return ListView.builder(
            itemCount: state.recentPurchases.length,
              itemBuilder: (context,index){
                final data=state.recentPurchases[index];
                return PurchaseTile(records: data,isPrint: false,);
              }
              );
          }
          return LoadingAnimationWidget.threeArchedCircle(color: AppColors.primaryColor, size: 30);
        },
      ),
    );
  }
}