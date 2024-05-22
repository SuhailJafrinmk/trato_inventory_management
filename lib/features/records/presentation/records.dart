import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';

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
                padding: EdgeInsets.all(10),
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
                    Text('Sellers'),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
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
                    Text('Customers'),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * .03,
        ),
        InkWell(
          onTap: () {
            // Navigator.pushNamed(context, 'add_purchase');
          },
          child: Material(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            elevation: 20,
            child: Container(
              height: height * .2,
              width: width * .8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: AppColors.backgroundColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/sales.jpg'),
                  ),
                  Text(
                    'Sales records',
                    style: categoryTitle,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: height * .05,
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, 'purchase_page');
          },
          child: Material(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
            elevation: 20,
            child: Container(
              height: height * .2,
              width: width * .8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: AppColors.backgroundColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/purchases.jpg'),
                    radius: 50,
                  ),
                  Text(
                    'purchase records',
                    style: categoryTitle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
