import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:trato_inventory_management/features/addpurchase/bloc/add_purchase_bloc.dart';
import 'package:trato_inventory_management/features/addpurchase/presentation/dialogues/product_quantity_modal.dart';
import 'package:trato_inventory_management/features/addpurchase/presentation/dialogues/supplier_data_sheet.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';
import 'package:trato_inventory_management/widgets/product_grid.dart';

class AddPurchase extends StatefulWidget {
  const AddPurchase({super.key});
  @override
  State<AddPurchase> createState() => _AddPurchaseState();
}
class _AddPurchaseState extends State<AddPurchase> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return BlocListener<AddPurchaseBloc, AddPurchaseState>(
      listener: (context, state) {
        if (state is PurchaseRecordAddingError) {
          Fluttertoast.showToast(
              msg: state.message,
              backgroundColor: Colors.red,
              textColor: Colors.white);
        } else if (state is PurchaseRecordAddSuccess) {
          Fluttertoast.showToast(
              msg: 'Successfully added record',
              backgroundColor: Colors.green,
              textColor: Colors.white);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Purchase'),
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
                              showQuantityModal(context, eachDocument);
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
                child: BlocBuilder<AddPurchaseBloc, AddPurchaseState>(
                  builder: (context, state) {
                    if (state is SinglePurchaseAddedState) {
                      DateTime now = DateTime.now();
                      String formattedNow = DateFormat('yyyy-MM-dd – kk:mm').format(now);
                      final totalCount = state.purcaseItems.isNotEmpty
                          ? state.purcaseItems
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
                              itemCount: state.purcaseItems.length,
                              itemBuilder: (context, index) {
                                final singleItem = state.purcaseItems[index];
                                return ListTile(
                                  title: Text(singleItem.productName),
                                  trailing: IconButton(
                                      onPressed: () {
                                        BlocProvider.of<AddPurchaseBloc>(context).add(DeleteButtonClicked(purchasedItem: singleItem));
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
                      child: Text('Please Select a product and\n add the required quanity'),
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
                        height: 50, 
                        child: CustomButton(
                          color: AppColors.primaryColor,
                          child: Text(
                            'Add Purchase',
                            style: buttonTextWhiteSmall,
                          ),
                          onTap: () {
                            showSellerForm(context, 'Supplier name', 'Supplier email');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 50, // Adjust the height as needed
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
