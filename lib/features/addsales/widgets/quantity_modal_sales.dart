// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:trato_inventory_management/features/addsales/bloc/add_sales_bloc.dart';
import 'package:trato_inventory_management/models/selled_item.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';

// ignore: must_be_immutable
class QuantityModalSales extends StatefulWidget {
  Map<String, dynamic> singleDoc;
  QuantityModalSales({required this.singleDoc});

  @override
  _QuantityModalState createState() => _QuantityModalState();
}

class _QuantityModalState extends State<QuantityModalSales> {
  int totalQuantity = 1;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [const Text('Select quantity'),
        Text('Please select the required quantity for the product',style: modalDescription,)],
      ),
      content: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: height * .16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    NetworkImage(widget.singleDoc['productImage'])),
                          ),
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        flex: 2,
                        child: SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.singleDoc['productName']),
                              Text('Supplier : ${widget.singleDoc['supplier']}'),
                              InputQty(
                                qtyFormProps: const QtyFormProps(enableTyping: true),
                                validator: (value) {
                                  final qty=widget.singleDoc['productQuantity'];
                                  if (value == null) {
                                    return 'value cannot be null';
                                  }
                                  if(value is double || value is! int){
                                    return 'value must be integer';
                                  }
                                  if(value>qty){
                                    return 'only $qty products are available';
                                  }
                                  return null;
                                },
                                minVal: 1,
                                onQtyChanged: (value) {
                                 totalQuantity = value.toInt();
                                  print(totalQuantity);
                                },
                                steps: 1,
                                initVal: 1,
                                maxVal: widget.singleDoc['productQuantity'],
                                decoration: const QtyDecorationProps(
                                  qtyStyle: QtyStyle.btnOnRight,
                                  plusBtn: Icon(Icons.arrow_drop_up),
                                  minusBtn: Icon(Icons.arrow_drop_down),
                                  constraints:
                                      BoxConstraints(minWidth: 80, minHeight: 20),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          children: [
            Expanded(flex: 1,child: CustomButton(height: height*.05,color: Colors.white,onTap: () => Navigator.pop(context),child: const Text('Cancel'),)),
             Expanded(flex: 1, child: CustomButton(height: height*.05,color: AppColors.primaryColor,
             onTap: () {
            final selledItem = SelledItem(
                  productName: widget.singleDoc['productName'],
                  supplierName: widget.singleDoc['supplier'],
                  quantity: totalQuantity,
                  price: widget.singleDoc['purchasePrice'],
                  totalItemAmount:
                  (totalQuantity * widget.singleDoc['purchasePrice']).toInt(),
                  );
                  BlocProvider.of<AddSalesBloc>(context).add(ConfirmSingleSale(selledItem: selledItem));
                  Navigator.pop(context);  
             },child: Text('Confirm',style: textbutton,),)),
          ],
        ),
        
      ],
    );
  }
}
