import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/records/bloc/records_page_bloc.dart';

class ListOfCustomers extends StatelessWidget {
  const ListOfCustomers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customers'),
      ),
     body: BlocBuilder<RecordsPageBloc, RecordsPageState>(
      builder: (context, state) {
        if(state is FetchedCustomerAndSellerDetails){
          return ListView.builder(
            itemCount: state.customerData.length,
            itemBuilder: (context, index) {
              final data=state.customerData[index];
              final customerName=data['customerName'];
              final customerEmail=data['customerEmail'];
              return ListTile(
                leading: CircleAvatar(),
                title: Text('${customerName}'),
                subtitle: Text('${customerEmail}'),
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