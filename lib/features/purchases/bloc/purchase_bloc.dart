import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

part 'purchase_event.dart';
part 'purchase_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  final firebase=FirebaseAuth.instance;
  PurchaseBloc() : super(PurchaseInitial()) {
 on<PrintButtonClicked>(printButtonClicked);
 on<DownloadButtonPressed>(downloadButtonPressed);
  }

  FutureOr<void> printButtonClicked(PrintButtonClicked event, Emitter<PurchaseState> emit)async{
    try{
    emit(PdfGenerationLoading());
  final pdf = pw.Document();
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Purchase Records', style: const pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 20),
            pw.Text('Supplier Name: ${event.data['supplierName']}'),
            pw.Text('Supplier Email: ${event.data['supplierEmail']}'),
            pw.Text('Purchase Date: ${event.data['purchaseDate']}'),
            pw.Text('Total Amount: ${event.data['totalAmount']}'),
            pw.SizedBox(height: 20),
            pw.Text('Items:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ...event.data['items'].map<pw.Widget>((item) {
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
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/purchase_record.pdf';
      final file = File(path);
      await file.writeAsBytes(await pdf.save());
      final storageRef = FirebaseStorage.instance.ref().child('pdfs/${DateTime.now().millisecondsSinceEpoch}.pdf');
      await storageRef.putFile(file);
      final downloadUrl = await storageRef.getDownloadURL();
      print('PDF uploaded successfully. Download URL: $downloadUrl');
      await FirebaseFirestore.instance.collection('UserData').doc(firebase.currentUser!.uid).collection('PurchaseRecords').doc(event.data['purchaseDate']).update({'Pdfpath':downloadUrl});
      emit(PdfGenerationSuccess(pdfPath: downloadUrl));
    }catch(e){
      emit(PdfGenerationError());
    }
}

  FutureOr<void> downloadButtonPressed(DownloadButtonPressed event, Emitter<PurchaseState> emit) {
    // final filename=
    final storage=FirebaseStorage.instance;
    
  }
}
