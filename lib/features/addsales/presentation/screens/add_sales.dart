import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:trato_inventory_management/features/AddSales/presentation/dialogues/supplier_data_sheet.dart';
import 'package:trato_inventory_management/features/addsales/bloc/add_sales_bloc.dart';
import 'package:trato_inventory_management/features/addsales/presentation/dialogues/product_quantity_modal_sales.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';
import 'package:trato_inventory_management/widgets/product_grid.dart';

class AddSales extends StatefulWidget {
  const AddSales({super.key});
  @override
  State<AddSales> createState() => _AddSalesState();
}
class _AddSalesState extends State<AddSales> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return BlocListener<AddSalesBloc, AddSalesState>(
      listener: (context, state) {
        if (state is CustomerDetalsAddSuccess) {
          Fluttertoast.showToast(
              msg: 'Successfully added record',
              backgroundColor: Colors.green,
              textColor: Colors.white);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Sales'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                flex: 4,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('UserData')
                      .doc(user!.uid)
                      .collection('Products')
                      .where('productQuantity', isGreaterThan: 0)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error fetching products'));
                    } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No Products available'));
                    } else {
                      final documents = snapshot.data!.docs;
                      final singleDocument = documents
                          .map((e) => e.data() as Map<String, dynamic>)
                          .toList();
                      return GridView.builder(
                        padding: const EdgeInsets.all(10),
                        scrollDirection: Axis.vertical,
                        itemCount: singleDocument.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                                childAspectRatio: 1 / 1.5,
                                crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          final eachDocument = singleDocument[index];
                          return ProductGrid(
                            subtitleTwo: 'Available : ${eachDocument['productQuantity']}',
                            productName: 'Product : ${eachDocument['productName']}',
                            subtitle: 'Price : ${eachDocument['purchasePrice']}',
                            productImage: eachDocument['productImage'],
                            onTap: () {
                                showQuantityModalSales(context, eachDocument);
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              Expanded(
                flex: 6,
                child: BlocBuilder<AddSalesBloc, AddSalesState>(
                  builder: (context, state) {
                    if (state is ItemQuanityAdded) {
                      DateTime now = DateTime.now();
                      String formattedNow = DateFormat('yyyy-MM-dd – kk:mm').format(now);
                      final totalCount = state.itemsAdded.isNotEmpty
                          ? state.itemsAdded
                              .map((item) => item.totalItemAmount)
                              .reduce((a, b) => a + b)
                          : 0;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Grand Total: $totalCount',
                            style: biggestTextBlack,
                          ),
                          Text('Date: $formattedNow'),
                          const SizedBox(height: 20),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: state.itemsAdded.length,
                              itemBuilder: (context, index) {
                                final singleItem = state.itemsAdded[index];
                                return ListTile(
                                  title: Text(singleItem.productName),
                                  trailing: IconButton(
                                      onPressed: () {
                                        BlocProvider.of<AddSalesBloc>(context).add((DeleteButtonClickedEvent(selledItem: singleItem)));
                                      },
                                      icon: const Icon(Icons.delete)),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Quantity: ${singleItem.quantity}'),
                                      Text('Total Amount: ${singleItem.totalItemAmount}'),
                                      Text('Supplier: ${singleItem.supplierName}')
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    return const Center(
                      child: Text('Please select a product and add the required quanity\n the max value will be the available quantity'),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50, // Adjust the height as needed
                        child: CustomButton(
                          color: AppColors.primaryColor,
                          child: Text(
                            'Add Sales',
                            style: buttonTextWhiteSmall,
                          ),
                          onTap: () {
                           showCustomerForm(context, 'Customer name', 'Customer Email');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: CustomButton(
                          onTap: () => Navigator.pop(context),
                          color: AppColors.primaryColor,
                          child: Text(
                            'Cancel',
                            style: buttonTextWhiteSmall,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
