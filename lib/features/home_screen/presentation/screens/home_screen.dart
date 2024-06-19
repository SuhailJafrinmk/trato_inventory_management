import 'dart:developer' as developer;
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:trato_inventory_management/features/addproduct/presentation/add_product.dart';
import 'package:trato_inventory_management/features/home_screen/bloc/home_screen_bloc.dart';
import 'package:trato_inventory_management/features/home_screen/presentation/screens/out_of_stock.dart';
import 'package:trato_inventory_management/features/home_screen/presentation/screens/recent_sales_page.dart';
import 'package:trato_inventory_management/features/home_screen/widgets/home_screen_container.dart';
import 'package:trato_inventory_management/features/home_screen/widgets/home_screen_tile.dart';
import 'package:trato_inventory_management/features/inventory/presentation/screens/inventory_page.dart';
import 'package:trato_inventory_management/features/product_details/presentation/product_details.dart';
import 'package:trato_inventory_management/features/profile/presentation/profile_page.dart';
import 'package:trato_inventory_management/features/records/presentation/records.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/image_links.dart';
import 'package:trato_inventory_management/utils/constants/navigation_items_list.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/features/home_screen/widgets/bottom_navigation.dart';
import 'package:trato_inventory_management/widgets/product_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController();
  int selectedIndex = 0;
  final List<String> AppbarTitles = ['Home', 'Inventory', 'Records', "profile"];
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppbarTitles[selectedIndex]),
      ),
      bottomNavigationBar: ScrollableBottomNavigationBar(
          backgroundColor: AppColors.primaryColor,
          items: navigationItems,
          selectedIndex: selectedIndex,
          onItemTapped: (index) {
            setState(() {
              selectedIndex = index;
              pageController.jumpToPage(index);
            });
          }),
      body: PageView(
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        children: [
          const HomeFirst(),
          const InventoryPage(),
          const Records(),
          ProfileScreen(),
        ],
      ),
    );
  }
}


class HomeFirst extends StatefulWidget {
  const HomeFirst({super.key});

  @override
  State<HomeFirst> createState() => _HomeFirstState();
}

class _HomeFirstState extends State<HomeFirst> {
  @override
  void initState() {
    BlocProvider.of<HomeScreenBloc>(context).add(FetchHomeScreenData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    User? user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Material(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Material(
                    elevation: 5,
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore
                          .instance // Retrieving the added store details from Firestore database
                          .collection('UserData')
                          .doc(user!.uid)
                          .collection('store details')
                          .doc(user.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(child: Text('Error fetching products'));
                        } else if (!snapshot.hasData || !snapshot.data!.exists) {
                          return const Center(child: Text('No stores added'));
                        } else {
                          final data = snapshot.data!.data() as Map<String, dynamic>;
                          final storename = data['storeName'];
                          final gstid = data['gstId'];
                          return ListTile(
                            leading: SizedBox(child: Image.asset(AppImages.shopDummyimage)),
                            title: Text(
                              storename,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'GST ID : $gstid',
                              style: const TextStyle(fontWeight: FontWeight.w300),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: size.height * .01),
                  BlocBuilder<HomeScreenBloc, HomeScreenState>(
                    builder: (context, state) {
                      if (state is HomeScreenDataLoading) {
                        return SizedBox(
                          child: LoadingAnimationWidget.threeArchedCircle(color: AppColors.primaryColor, size: 20),
                        );
                      }
                      if (state is HomeScreenDataSuccess) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    HomeScreenContainer(
                                      data: '${state.dataToBeDisplayed['totalSaleAmount']}', title: 'Total sale amount'),
                                    HomeScreenContainer(
                                      data: '${state.dataToBeDisplayed['totalStock']}', title: 'Total stock price')
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    HomeScreenContainer(
                                      data: '${state.dataToBeDisplayed['totalPurchases']}', title: 'Total purchase'),
                                    HomeScreenContainer(
                                      data: '${state.dataToBeDisplayed['totalProducts']}', title: 'Total products')
                                  ],
                                ),
                                SizedBox(height: size.height * .03),
                                Divider(),
                              ],
                            ),
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                  SizedBox(
                    width: size.width*.95,
                    height: size.height*.3,
                    child: ListView(
                      children: [
                        HomeScreenTile(contentType: 'Out of stock',onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>OutOfStockItems())),),
                        HomeScreenTile(contentType: 'Recently added'),
                        HomeScreenTile(contentType: 'Recent sale',onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context)=>RecentSalesPage())),),
                        HomeScreenTile(contentType: 'Recent purchase'),               
                        ],
                    ),
                  ),
                ],
              ),
            ),
            // Floating Action Button positioned on top of the content
            Positioned(
              bottom: size.height * 0.02,
              right: size.width * 0.32,
             child: ElevatedButton(
              onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProduct()));
             }, child: Row(
              children: [Text('Add Product'),
              Icon(Icons.add)],)),
            ),
          ],
        ),
      ),
    );
  }
}
