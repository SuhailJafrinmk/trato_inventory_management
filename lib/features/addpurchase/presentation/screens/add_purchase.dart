import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:trato_inventory_management/features/addpurchase/bloc/add_purchase_bloc.dart';
import 'package:trato_inventory_management/features/addpurchase/presentation/dialogues/supplier_data_sheet.dart';
import 'package:trato_inventory_management/features/addpurchase/presentation/dialogues/product_quantity_modal.dart';
import 'package:trato_inventory_management/models/purchased_item.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/product_grid.dart';


class AddPurchase extends StatefulWidget {
  const AddPurchase({super.key});

  @override
  State<AddPurchase> createState() => _AddPurchaseState();
}

class _AddPurchaseState extends State<AddPurchase> {
  List<PurchasedItem> itemsPurchased = [];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    User? user = FirebaseAuth.instance.currentUser;
    String selected_item = 'mobile tech';
    print('width of device:$width');
    print('height of device:$height');
    return BlocListener<AddPurchaseBloc, AddPurchaseState>(
      listener: (context, state) {
        if (state is SinglePurchaseAddedState) {
          itemsPurchased.addAll(state.purcaseItems);
        } else if (state is PurchaseRecordAddingError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is PurchaseRecordAddSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Record Added successfully')));
        } else if (state is PurchaseListUpdated) {}
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Purchase'),
        ),
        body: SafeArea(
            child: Container(
          // padding: const EdgeInsets.all(3),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: height * .4,
                width: width,
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
                      return const Center(
                          child: Text('Error fetching products'));
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No Products available'));
                    } else {
                      final documents = snapshot.data!.docs;
                      final singledocument = documents
                          .map((e) => e.data() as Map<String, dynamic>)
                          .toList();
                      return GridView.builder(
                          padding: const EdgeInsets.all(10),
                          scrollDirection: Axis.vertical,
                          itemCount: singledocument.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                  childAspectRatio: 1 / 1.5,
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            final eachdocument = singledocument[index];
                            return ProductGrid(
                              subtitleTwo: 'Available : ${eachdocument['productQuantity']}',
                              productName: 'Product : ${eachdocument['productName']}',
                              subtitle: 'Price : ${eachdocument['purchasePrice']}',
                              productImage: eachdocument['productImage'],
                              onTap: () {
                                showQuantityModal(
                                    context, eachdocument, itemsPurchased);
                              },
                            );
                          });
                    }
                  },
                ),
              ),
              Expanded(
                  child: Container(
                width: width,
                child: Column(
                  children: [
                    BlocBuilder<AddPurchaseBloc, AddPurchaseState>(
                      builder: (context, state) {
                        DateTime now = DateTime.now();
                        String formattedNow =
                            DateFormat('yyyy-MM-dd – kk:mm').format(now);
                        final totalCount = itemsPurchased.isNotEmpty
                            ? itemsPurchased
                                .map((item) => item.totalItemAmount)
                                .reduce((a, b) => a + b)
                            : 0;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Grand Totel: $totalCount',
                              style: biggestTextBlack,
                            ),
                            Text('Date:$formattedNow'),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: height * .3,
                      width: width,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: itemsPurchased.length,
                        itemBuilder: (context, index) {
                          final singleItem = itemsPurchased[index];
                          return ListTile(
                            title: Text(singleItem.productName),
                            trailing: IconButton(
                                onPressed: () {
                                  // bloc.add(DeleteButtonClicked(purchasedItem: singleItem));
                                },
                                icon: Icon(Icons.delete)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Quanity:${singleItem.quantity}'),
                                Text(
                                    'Total Amount:${singleItem.totalItemAmount}'),
                                Text('Supplier:${singleItem.supplierName}')
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                        child: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                showCustomerForm(context, 'Supplier name',
                                    'Supplier email', itemsPurchased);
                              },
                              child: const Text('Add')),
                          ElevatedButton(
                              onPressed: () {}, child: const Text('cancel'))
                        ],
                      ),
                    ))
                  ],
                ),
              ))
            ],
          ),
        )),
      ),
    );
  }
}




