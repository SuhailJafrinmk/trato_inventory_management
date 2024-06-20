import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/addsales/presentation/screens/add_sales.dart';
import 'package:trato_inventory_management/features/records/bloc/records_page_bloc.dart';
import 'package:trato_inventory_management/features/records/presentation/customers_page.dart';
import 'package:trato_inventory_management/features/records/presentation/sellers_page.dart';
import 'package:trato_inventory_management/features/sales/presentation/screens/sales_page.dart';
import 'package:trato_inventory_management/utils/constants/image_links.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/record_page_widget.dart';

class Records extends StatefulWidget {
  const Records({super.key});

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  @override
  void initState() {
    BlocProvider.of<RecordsPageBloc>(context)
        .add(FetchSellerAndCustomerDetails());
    super.initState();
  }

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
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ListOfSellers()));
                },
                child: Container(
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
                      BlocBuilder<RecordsPageBloc, RecordsPageState>(
                        builder: (context, state) {
                          if (state is FetchedCustomerAndSellerDetails) {
                            return Text(
                              '${state.sellerData.length}',
                              style: categoryTitle,
                            );
                          }
                          return Text(
                            'Not available',
                          );
                        },
                      ),
                      const Text('Sellers'),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ListOfCustomers()));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 145, 155, 162),
                      borderRadius: BorderRadius.circular(20)),
                  width: width * .4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<RecordsPageBloc, RecordsPageState>(
                        builder: (context, state) {
                          if(state is FetchedCustomerAndSellerDetails){
                            developer.log('items in customer data are ${state.customerData}');
                            developer.log('items in seller data are ${state.sellerData}');
                            return Text('${state.customerData.length}',style: categoryTitle,);
                          }
                          return Text(
                            'not available',
                          );
                        },
                      ),
                      const Text('Customers'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * .03,
        ),
        RecordsAddTile(
          backgroundImage: AppImages.recordPurchase,
          title: 'Purchase Records',
          onTapView: () => Navigator.pushNamed(context, 'purchase_page'),
          onTapAdd: () => Navigator.pushNamed(context, 'add_purchase'),
        ),
        SizedBox(
          height: height * .05,
        ),
        RecordsAddTile(
          backgroundImage: AppImages.recordsSales,
          title: 'Sales Records',
          onTapView: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => SalesList())),
          onTapAdd: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddSales())),
        ),
      ],
    ));
  }
}
