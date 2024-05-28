import 'package:flutter/material.dart';
import 'package:trato_inventory_management/features/addpurchase/presentation/add_purchase.dart';
import 'package:trato_inventory_management/features/sales/presentation/sales_page.dart';
import 'package:trato_inventory_management/utils/constants/image_links.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/record_page_widget.dart';

class Records extends StatelessWidget {
  const Records({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height * .05,
        ),
        SizedBox(
          height: height * .1,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 108, 142, 164),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: width * .4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1223',
                      style: categoryTitle,
                    ),
                    const Text('Sellers'),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 145, 155, 162),
                    borderRadius: BorderRadius.circular(20)),
                width: width * .4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1223',
                      style: categoryTitle,
                    ),
                    const Text('Customers'),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * .03,
        ),
        RecordsAddTile(backgroundImage: AppImages.recordPurchase,
         title: 'Purchase Records',
         onTapView: () => Navigator.pushNamed(context, 'purchase_page'),
         onTapAdd: () => Navigator.pushNamed(context, 'add_purchase'),
         ),
        SizedBox(
          height: height * .05,
        ),
        RecordsAddTile(backgroundImage: AppImages.recordsSales, title: 'Sales Records',
        onTapView: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>SalesPage())),
        onTapAdd: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPurchase())),
        ),
             ],
    ));
  }
}
