
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/records/bloc/records_page_bloc.dart';

class ListOfSellers extends StatelessWidget {
  const ListOfSellers({super.key});

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sellers'),
      ),
     body: BlocBuilder<RecordsPageBloc, RecordsPageState>(
      builder: (context, state) {
        if(state is FetchedCustomerAndSellerDetails){
          if(state.customerData.isEmpty){
             return  SizedBox(
              height: height,
              width: width,
              child: const Center(
                child: Text('There is no customer data available at the moment'),
              ),
            );
          }
          return ListView.builder(
            itemCount: state.sellerData.length,
            itemBuilder: (context, index) {
              final data=state.sellerData[index];
              final sellerName=data['supplierName'];
              final sellerEmail=data['supplierEmail'];
              return ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('assets/images/supplier_icon.png'),
                ),
                title: Text('$sellerName'),
                subtitle: Text('$sellerEmail'),
              );
            },
            );
        }
        return const SizedBox();
      },
     ),
    );
  }
}