import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:trato_inventory_management/features/addproduct/presentation/add_product.dart';
import 'package:trato_inventory_management/features/home_screen/bloc/home_screen_bloc.dart';
import 'package:trato_inventory_management/features/home_screen/presentation/screens/out_of_stock.dart';
import 'package:trato_inventory_management/features/home_screen/presentation/screens/recent_purchases.dart';
import 'package:trato_inventory_management/features/home_screen/presentation/screens/recent_sales_page.dart';
import 'package:trato_inventory_management/features/home_screen/widgets/home_screen_container.dart';
import 'package:trato_inventory_management/features/home_screen/widgets/home_screen_tile.dart';
import 'package:trato_inventory_management/features/inventory/presentation/screens/inventory_page.dart';
import 'package:trato_inventory_management/features/profile/presentation/profile_page.dart';
import 'package:trato_inventory_management/features/records/presentation/records.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/image_links.dart';
import 'package:trato_inventory_management/utils/constants/navigation_items_list.dart';
import 'package:trato_inventory_management/features/home_screen/widgets/bottom_navigation.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController();
  int selectedIndex = 0;
  final List<String> appbarTitles = ['Home', 'Inventory', 'Records', "profile"];
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
        title: AutoSizeText(appbarTitles[selectedIndex]),
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
                          return const Center(child: AutoSizeText('Error fetching products'));
                        } else if (!snapshot.hasData || !snapshot.data!.exists) {
                          return const Center(child: AutoSizeText('No stores added'));
                        } else {
                          final data = snapshot.data!.data() as Map<String, dynamic>;
                          final storename = data['storeName'];
                          final gstid = data['gstId'];
                          return ListTile(
                            leading: SizedBox(child: Image.asset(AppImages.shopDummyimage)),
                            title: AutoSizeText(
                              storename,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            subtitle: AutoSizeText(
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
                          height: size.height*.4,
                          width: size.width,
                          child: Center(
                            child: LoadingAnimationWidget.threeArchedCircle(color: AppColors.primaryColor, size: 30)
                            ),
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
                                      backgroundImage:'assets/images/total_sales_amount.png',
                                      data: '${state.dataToBeDisplayed['totalSaleAmount']}', title: 'Total sale amount'),
                                    HomeScreenContainer(
                                      backgroundImage: 'assets/images/total_stock_price.png',
                                      data: '${state.dataToBeDisplayed['totalStock']}', title: 'Total stock price')
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    HomeScreenContainer(
                                      backgroundImage: 'assets/images/total_purchases.png',
                                      data: '${state.dataToBeDisplayed['totalPurchases']}', title: 'Total purchase'),
                                    HomeScreenContainer(
                                      backgroundImage: 'assets/images/total_products.png',
                                      data: '${state.dataToBeDisplayed['totalProducts']}', title: 'Total products')
                                  ],
                                ),
                                SizedBox(height: size.height * .03),
                                const Divider(),
                              ],
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  SizedBox(
                    width: size.width*.95,
                    height: size.height*.3,
                    child: ListView(
                      children: [
                        HomeScreenTile(contentType: 'Out of stock',onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>OutOfStockItems())),),
                        HomeScreenTile(contentType: 'Recent sale',onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context)=>const RecentSalesPage())),),
                        HomeScreenTile(contentType: 'Recent purchase',onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>const RecentPurchases())),),               
                        ],
                    ),
                  ),
                ],
              ),
            ),
            // Floating Action Button positioned on top of the content
            Positioned(
              bottom: size.height * 0.02,
              right: size.width * 0.3,
              child: CustomButton(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProduct()));
                },
                elevation: 30,
                width: size.width*.36,
              height: size.height*.06,
              color: AppColors.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.add_box,color: Colors.white,),
                  Text('Add product',style: buttonTextWhiteSmall,)
                ],
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
