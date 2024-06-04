import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:trato_inventory_management/features/addpurchase/bloc/add_purchase_bloc.dart';
import 'package:trato_inventory_management/models/purchase_record_model.dart';
import 'package:trato_inventory_management/models/purchased_item.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/regex.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/app_textfield.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';
import 'package:trato_inventory_management/widgets/product_grid.dart';
import 'package:trato_inventory_management/widgets/product_quantity_select_modal.dart';

class AddPurchase extends StatefulWidget {
  const AddPurchase({super.key});

  @override
  State<AddPurchase> createState() => _AddPurchaseState();
}

class _AddPurchaseState extends State<AddPurchase> {
  List<PurchasedItem> itemsPurchased = [];
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AddPurchaseBloc>(context);
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
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Purchase'),
        ),
        body: SafeArea(
            child: Container(
          padding: const EdgeInsets.all(10),
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
                      return const Center(
                          child: Text('No categories available'));
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
                              productName: eachdocument['productName'],
                              subtitle: eachdocument['category'],
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
                decoration: BoxDecoration(border: Border.all()),
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

void showQuantityModal(BuildContext context, Map<String, dynamic> singleDoc,
    List<PurchasedItem> itemsPurchased) {
  showDialog(
      context: context,
      builder: (context) {
        return QuantityModal(
          singleDoc: singleDoc,
          itemsPurchased: itemsPurchased,
        );
      });
}

void showCustomerForm(BuildContext context, String typeName, String typeEmail,
    List<PurchasedItem> items) {
  TextEditingController customerController = TextEditingController();
  TextEditingController customerEmailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final customerFocusNode = FocusNode();
  final emailFocusNode = FocusNode();

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: BlocBuilder<AddPurchaseBloc, AddPurchaseState>(
                builder: (context, state) {
                  if(state is PurchaseRecordAddLoading){
                    return const Center(
                      child: const Column(
                        children: [
                          CircularProgressIndicator(),
                          Text("adding your purchase record"),
                        ],
                      ),
                    );
                  }
                  return Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppTextfield(
                          focusNode: customerFocusNode,
                          validateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please add a supplier name';
                            }
                            if (value.length > 30) {
                              return 'Please make the name shorter than 30 characters';
                            }
                            return null;
                          },
                          textEditingController: customerController,
                          labelText: typeName,
                          width: double.infinity,
                          padding: 10,
                          obscureText: false,
                          fillColor: Colors.white,
                        ),
                        AppTextfield(
                          focusNode: emailFocusNode,
                          validateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please add supplier mail';
                            }
                            if (!RegexUtils.emailRegExp.hasMatch(value)) {
                              return 'Enter a valid mail';
                            }
                            return null;
                          },
                          textEditingController: customerEmailController,
                          labelText: typeEmail,
                          width: double.infinity,
                          padding: 10,
                          obscureText: false,
                          fillColor: Colors.white,
                        ),
                        CustomButton(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              DateTime now = DateTime.now();
                              String formattedNow =
                                  DateFormat('yyyy-MM-dd – kk:mm').format(now);
                              final totalCount = items.isNotEmpty
                                  ? items
                                      .map((item) => item.totalItemAmount)
                                      .reduce((a, b) => a + b)
                                  : 0;
                              PurchaseRecord record = PurchaseRecord(
                                purchaseDate: formattedNow,
                                items: items,
                                totalAmount: totalCount,
                                supplierEmail: customerEmailController.text,
                                supplierName: customerController.text,
                              );
                              BlocProvider.of<AddPurchaseBloc>(context)
                                  .add(AddRecordConfirm(record: record));
                            }
                          },
                          height: 60,
                          width: double.infinity,
                          elevation: 10,
                          color: AppColors.primaryColor,
                          radius: 10,
                          child: Text(
                            'Confirm',
                            style: buttonText,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    },
  ).whenComplete(() {
    // Dispose focus nodes to avoid memory leaks
    customerFocusNode.dispose();
    emailFocusNode.dispose();
  });

  // Request focus after a short delay to ensure the modal is fully opened
  Future.delayed(const Duration(milliseconds: 100), () {
    customerFocusNode.requestFocus();
  });
}
