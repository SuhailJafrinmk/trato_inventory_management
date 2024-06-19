import 'package:flutter/material.dart';


class SalesTile extends StatelessWidget {
  final Map<String, dynamic> records;
  void Function()? onTap;
  void Function()? printIconPressed;

  SalesTile(
      {super.key,
      required this.records,
      this.onTap,
      this.printIconPressed,
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
    );
  }
}
