import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'sales_event.dart';
part 'sales_state.dart';

class SalesBloc extends Bloc<SalesEvent, SalesState> {
  final firebase=FirebaseAuth.instance;
  SalesBloc() : super(SalesInitial()) {
  on<PrintSalesButtonClicked>(printSalesButtonClicked);
  }

  

  FutureOr<void> printSalesButtonClicked(PrintSalesButtonClicked event, Emitter<SalesState> emit)async {
     try {
    emit(SalesPdfGenerateLoading());

   //for generating the pdf with the required data 
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Purchase Records', style: const pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              pw.Text('Customer Name: ${event.data['customerName']}'),
              pw.Text('Customer Email: ${event.data['customerEmail']}'),
              pw.Text('Purchase Date: ${event.data['saleDate']}'),
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

    // Save PDF locally in temporary directory
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/sale_record.pdf';
    final file = File(path);
    await file.writeAsBytes(await pdf.save());

    // Upload the PDF to Firebase Storage
    final storageRef = FirebaseStorage.instance.ref().child('Salespdfs/${DateTime.now().millisecondsSinceEpoch}.pdf');
    await storageRef.putFile(file);
    final downloadUrl = await storageRef.getDownloadURL();
    print('PDF uploaded successfully. Download URL: $downloadUrl');

    // Updating the sale document with the link of the pdf
    await FirebaseFirestore.instance
        .collection('UserData')
        .doc(firebase.currentUser!.uid)
        .collection('SalesRecord')
        .doc(event.data['saleDate'])
        .update({'Pdfpath': downloadUrl});

    // Display the locally stored PDF
    displaySalesPDF(file);

    emit(SalesPdfGenerateSuccess());
  } catch (e) {
    emit(SalesPdfGenerateError());
  }

  }
}
void displaySalesPDF(File pdfFile) {
  Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdfFile.readAsBytes());
}