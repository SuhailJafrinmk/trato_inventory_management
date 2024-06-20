import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/records/bloc/records_page_bloc.dart';

class ListOfSellers extends StatelessWidget {
  const ListOfSellers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sellers'),
      ),
     body: BlocBuilder<RecordsPageBloc, RecordsPageState>(
      builder: (context, state) {
        if(state is FetchedCustomerAndSellerDetails){
          return ListView.builder(
            itemCount: state.sellerData.length,
            itemBuilder: (context, index) {
              final data=state.sellerData[index];
              final sellerName=data['supplierName'];
              final sellerEmail=data['supplierEmail'];
              return ListTile(
                leading: CircleAvatar(),
                title: Text('${sellerName}'),
                subtitle: Text('${sellerEmail}'),
              );
            },
            );
        }
        return SizedBox();
      },
     ),
    );
  }
}