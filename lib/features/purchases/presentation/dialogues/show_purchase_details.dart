import 'package:flutter/material.dart';

void showPurchaseDetails(BuildContext context, Map<String, dynamic> records) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Purchase Records'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Supplier Name: ${records['supplierName']}'),
              Text('Supplier Email: ${records['supplierEmail']}'),
              Text('Purchase Date: ${records['purchaseDate']}'),
              Text('Total Amount: ${records['totalAmount']}'),
              const SizedBox(height: 10),
              const Text('Items:', style: TextStyle(fontWeight: FontWeight.bold)),
              ...records['items'].map<Widget>((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Product Name: ${item['productName']}'),
                      Text('Price: ${item['price']}'),
                      Text('Quantity: ${item['quantity']}'),
                      Text('Supplier Name: ${item['supplierName']}'),
                      Text('Total Item Amount: ${item['totalItemAmount']}'),
                      const SizedBox(height: 5),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
