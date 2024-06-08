import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:trato_inventory_management/features/purchases/bloc/purchase_bloc.dart';
import 'package:trato_inventory_management/widgets/purchase_tile.dart';
import 'package:pdf/widgets.dart' as pw;

class PurchasesList extends StatelessWidget {
  User ? user=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase records'),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('UserData').doc(user!.uid).collection('PurchaseRecords').snapshots(),
           builder:(context,snapshot){
              if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error fetching products'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No categories available'));
                  }else{
                    final data=snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder:((context, index) {   
                        final documentData=data[index].data() as Map<String,dynamic>;
                        return PurchaseTile(records: documentData,onTap:()=>ShowPurchaseDetails(context,documentData),printIconPressed: ()async {
                          // BlocProvider.of<PurchaseBloc>(context).add(PrintButtonClicked(data: documentData));
                          generatePDF(context, documentData);
                        },);
                      }) 
                      );
                  }
           }
           )
      ),
    );
  }
}
void ShowPurchaseDetails(BuildContext context, Map<String, dynamic> records) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Purchase Records'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Supplier Name: ${records['supplierName']}'),
              Text('Supplier Email: ${records['supplierEmail']}'),
              Text('Purchase Date: ${records['purchaseDate']}'),
              Text('Total Amount: ${records['totalAmount']}'),
              SizedBox(height: 10),
              Text('Items:', style: TextStyle(fontWeight: FontWeight.bold)),
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
                      SizedBox(height: 5),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> generatePDF(BuildContext context, Map<String, dynamic> purchaseRecord) async {
  final pdf = pw.Document();
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Purchase Records', style: pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 20),
            pw.Text('Supplier Name: ${purchaseRecord['supplierName']}'),
            pw.Text('Supplier Email: ${purchaseRecord['supplierEmail']}'),
            pw.Text('Purchase Date: ${purchaseRecord['purchaseDate']}'),
            pw.Text('Total Amount: ${purchaseRecord['totalAmount']}'),
            pw.SizedBox(height: 20),
            pw.Text('Items:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ...purchaseRecord['items'].map<pw.Widget>((item) {
              return pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 5.0),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Product Name: ${item['productName']}'),
                    pw.Text('Price: ${item['price']}'),
                    pw.Text('Quantity: ${item['quantity']}'),
                    pw.Text('Supplier Name: ${item['supplierName']}'),
                    pw.Text('Total Item Amount: ${item['totalItemAmount']}'),
                    pw.SizedBox(height: 5),
                  ],
                ),
              );
            }).toList(),
          ],
        );
      },
    ),
  );
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/example.pdf';
  print(path);
  final file = File(path);
  await file.writeAsBytes(await pdf.save());
  print('file written');

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('PDF Generated'),
      content: Text('PDF has been saved to $path'),
      actions: [
        // FlatButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   child: Text('OK'),
        // ),
      ],
    ),
  );
}
