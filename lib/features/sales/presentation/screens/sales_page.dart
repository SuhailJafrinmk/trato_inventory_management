import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/purchases/bloc/purchase_bloc.dart';
import 'package:trato_inventory_management/features/purchases/presentation/dialogues/show_purchase_details.dart';
import 'package:trato_inventory_management/features/purchases/widgets/purchase_tile.dart';
import 'package:trato_inventory_management/features/sales/bloc/sales_bloc.dart';
import 'package:trato_inventory_management/features/sales/widgets/sales_record_tile.dart';

class SalesList extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<SalesBloc, SalesState>(
      listener: (context, state) {
        // if(state is PdfGenerationSuccess){
        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pdf generated')));
        //   // Navigator.push(context, MaterialPageRoute(builder: (context)=>PDFViewerScreen(state.pdfPath)));
        // }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sales records'),
        ),
        body: SafeArea(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('UserData')
                    .doc(user!.uid)
                    .collection('SalesRecord')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error fetching records'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No records available'));
                  } else {
                    final data = snapshot.data!.docs;
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: ((context, index) {
                          final documentData =
                              data[index].data() as Map<String, dynamic>;
                          return SalesTile(
                            records: documentData,
                            printIconPressed: () {
                              BlocProvider.of<SalesBloc>(context).add(PrintSalesButtonClicked(data: documentData));
                            },
                            );
                        }));
                  }
                })),
      ),
    );
  }
}
