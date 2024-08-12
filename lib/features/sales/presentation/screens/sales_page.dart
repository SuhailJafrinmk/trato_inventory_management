// ignore_for_file: use_key_in_widget_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:trato_inventory_management/features/sales/bloc/sales_bloc.dart';
import 'package:trato_inventory_management/features/sales/widgets/sales_record_tile.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'dart:developer' as developer;

class SalesList extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesBloc, SalesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const AutoSizeText('Sales records'),
          ),
          body: Stack(
            children: [
              SafeArea(
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
                      return const Center(child: AutoSizeText('Error fetching records'));
                    } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: AutoSizeText('No records available'));
                    } else {
                      final data = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: ((context, index) {
                          final documentData = data[index].data() as Map<String, dynamic>;
                          return SalesTile(
                            records: documentData,
                            printIconPressed: () {
                              developer.log('the print sales button is clicked');
                              BlocProvider.of<SalesBloc>(context).add(PrintSalesButtonClicked(data: documentData));
                            },
                          );
                        }),
                      );
                    }
                  },
                ),
              ),
              if (state is SalesPdfGenerateLoading)
                Positioned(
                  bottom: 20,
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LoadingAnimationWidget.threeArchedCircle(color: AppColors.primaryColor, size: 20),
                          const SizedBox(width: 20),
                          const AutoSizeText("Generating PDF..."),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

