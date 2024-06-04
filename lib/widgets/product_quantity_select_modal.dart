import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:trato_inventory_management/features/addpurchase/bloc/add_purchase_bloc.dart';
import 'package:trato_inventory_management/models/purchased_item.dart';

class QuantityModal extends StatefulWidget {
  Map<String, dynamic> singleDoc;
  List<PurchasedItem>itemsPurchased=[];
  QuantityModal({required this.singleDoc,required this.itemsPurchased});

  @override
  _QuantityModalState createState() => _QuantityModalState();
}

class _QuantityModalState extends State<QuantityModal> {
  dynamic totalQuantity = 2;
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AddPurchaseBloc>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return AlertDialog(
      title: const Text('Select quantity'),
      content: Column(
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
                            validator: (value) {
                              if (value == null) {
                                return 'value cannot be null';
                              }
                              return null;
                            },
                            minVal: 1,
                            onQtyChanged: (value) {
                              totalQuantity = value;
                              print(totalQuantity);
                            },
                            steps: 1,
                            initVal: 1,
                            maxVal: 5000,
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
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
            child: const Text('Confirm'),
            onPressed: () {
              //  bloc.add(QuantityConfirmButtonClicked(
              //   purchasedItem: PurchasedItem(productName: widget.singleDoc['productName'], quantity: totalQuantity, price: widget.singleDoc['purchasePrice'], totalItemAmount: totalQuantity*widget.singleDoc['purchasePrice'])
              //  ));
            final purchasedItem = PurchasedItem(
                  productName: widget.singleDoc['productName'],
                  supplierName: widget.singleDoc['supplier'],
                  quantity: totalQuantity,
                  price: widget.singleDoc['purchasePrice'],
                  totalItemAmount:
                  totalQuantity * widget.singleDoc['purchasePrice']
                  );
                  widget.itemsPurchased.add(purchasedItem);
             
            }),
      ],
    );
  }
}
