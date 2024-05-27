
import 'package:flutter/material.dart';

class QuantityModal extends StatefulWidget {
  final String productName;

  const QuantityModal({required this.productName});

  @override
  _QuantityModalState createState() => _QuantityModalState();
}

class _QuantityModalState extends State<QuantityModal> {
  int _quantity = 1;

  void _confirm() {
    print('Quantity confirmed for ${widget.productName}: $_quantity');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select quantity for ${widget.productName}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Select Quantity:'),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    if (_quantity > 1) _quantity--;
                  });
                },
              ),
              Text('$_quantity', style: TextStyle(fontSize: 20)),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    _quantity++;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('Confirm'),
          onPressed: _confirm,
        ),
      ],
    );
  }
}