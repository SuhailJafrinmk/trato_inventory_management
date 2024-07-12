import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:trato_inventory_management/features/home_screen/bloc/home_screen_bloc.dart';
import 'package:trato_inventory_management/features/sales/widgets/sales_record_tile.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';

class RecentSalesPage extends StatelessWidget {
  const RecentSalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent sales'),
      ),
      body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          if(state is HomeScreenDataSuccess){
            if(state.recentSales.isEmpty){
              return const Center(
                child: Text('There is no recent sales to display'),
              );
            }
          return ListView.builder(
            itemCount: state.recentSales.length,
              itemBuilder: (context,index){
                final data=state.recentSales[index];
                return SalesTile(records: data,isPrint: false,);
              }
              );
          }
          return LoadingAnimationWidget.threeArchedCircle(color: AppColors.primaryColor, size: 30);
        },
      ),
    );
  }
}