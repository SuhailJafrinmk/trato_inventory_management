import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/purchases/bloc/purchase_bloc.dart';
import 'package:trato_inventory_management/features/sales/bloc/sales_bloc.dart';

class SalesTile extends StatelessWidget {
  final Map<String, dynamic> records;
  void Function()? onTap;
  void Function()? printIconPressed;
  void Function()? downloadPressed;

  SalesTile(
      {super.key,
      required this.records,
      this.onTap,
      this.printIconPressed,
      this.downloadPressed});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SalesBloc, SalesState>(
      listener: (context, state) {
        if(state is SalesPdfGenerateSuccess){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pdf generated')));
        }
      },
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Sale',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      records['saleDate'],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Total: ${records['totalAmount']}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Supplier: ${records['customerName']}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    BlocBuilder<SalesBloc, SalesState>(
                      builder: (context, state) {
                        if (state is SalesPdfGenerateLoading) {
                          return const CircularProgressIndicator();
                        }
                        return IconButton(
                          icon: const Icon(Icons.print),
                          onPressed: printIconPressed,
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.download),
                      onPressed: downloadPressed,
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
