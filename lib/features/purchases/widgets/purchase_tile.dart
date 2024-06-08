import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/purchases/bloc/purchase_bloc.dart';

class PurchaseTile extends StatelessWidget {
  final Map<String, dynamic> records;
  void Function()? onTap;
  void Function()? printIconPressed;
  void Function()? downloadPressed;

  PurchaseTile(
      {super.key,
      required this.records,
      this.onTap,
      this.printIconPressed,
      this.downloadPressed});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PurchaseBloc, PurchaseState>(
      listener: (context, state) {
        
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
                    Text(
                      'Purchase',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      records['purchaseDate'],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Total: ${records['totalAmount']}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Supplier: ${records['supplierName']}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    BlocBuilder<PurchaseBloc, PurchaseState>(
                      builder: (context, state) {
                        if (state is PdfGenerationLoading) {
                          return CircularProgressIndicator();
                        }
                        return IconButton(
                          icon: Icon(Icons.print),
                          onPressed: printIconPressed,
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.download),
                      onPressed: downloadPressed,
                    ),
                    IconButton(
                      icon: Icon(Icons.more_vert),
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
