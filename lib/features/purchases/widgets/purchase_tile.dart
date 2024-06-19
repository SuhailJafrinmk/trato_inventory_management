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
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          onTap: onTap,
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'Purchase',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        records['purchaseDate'],
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
                    'Supplier: ${records['supplierName']}',
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
                  
                        
                           IconButton(
                            icon: const Icon(Icons.print),
                            onPressed: printIconPressed,
                          ),
                     
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
