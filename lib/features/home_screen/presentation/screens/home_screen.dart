import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trato_inventory_management/features/inventory/presentation/screens/inventory_page.dart';
import 'package:trato_inventory_management/features/profile/presentation/profile_page.dart';
import 'package:trato_inventory_management/features/records/presentation/records.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/image_links.dart';
import 'package:trato_inventory_management/utils/constants/navigation_items_list.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/features/home_screen/widgets/bottom_navigation.dart';
import 'package:trato_inventory_management/features/home_screen/widgets/carousel_slider.dart';
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

class HomeFirst extends StatelessWidget {
  const HomeFirst({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    User? user = FirebaseAuth.instance.currentUser;
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Material(
            elevation: 5,
            child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance  //retrieivng the added store details from firestore database
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
                  } else if (!snapshot.hasData || !snapshot.hasData) {
                    return const Center(child: Text('No stores added'));
                  } else {
                    final data = snapshot.data!.data() as Map<String, dynamic>;
                    final storename = data['storeName'];
                    final gstid = data['gstId'];
                    return ListTile(
                      leading: SizedBox(
                          child: Image.asset(AppImages.shopDummyimage)),
                      title: Text(storename),
                      subtitle: Text('Gst id:${gstid}'),
                    );
                  }
                }),
          ),
          SizedBox(
            height: size.height * .03,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
        .collection('UserData')
        .doc(user.uid)
        .collection('PurchaseRecords').snapshots(),
            builder:(context,snapshot){
              if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        // final records=snapshot.data?.docs ?? [];
        // double totalPrice=0;
        // for(var record in records){
        //   totalPrice=record['totalAmount'];
        // }
              return CarouselSlider(items: const [
              CarouselContainer(
                  data: 'Total Costs',
                  datatype: '10000 \$',
                  imageurl: AppImages.costsImage),
              CarouselContainer(
                  data: 'Total Stock',
                  datatype: '10000 \$',
                  imageurl: AppImages.salesImage),
              CarouselContainer(
                  data: 'Total Sales',
                  datatype: '10000 \$',
                  imageurl: AppImages.stockImage),
            ], options: CarouselOptions(autoPlay: true)
            );
            }
          ),
          SizedBox(
            height: size.height * .03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Smartphones',
                style: categoryTitle,
              ),
              TextButton(onPressed: () {}, child: const Text('See All')),
            ],
          ),
          SizedBox(
            height: size.height * .25,
            width: size.width,
            child: GridView.count(
              crossAxisCount: 1,
              scrollDirection: Axis.horizontal,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 3 / 3,
              children: [
                ProductGrid(
                  productName: 'Pixel 7A',
                  subtitle: 'only 2 stock',
                  productImage: AppImages.pixelImage,
                ),
                ProductGrid(
                  productName: 'Samsung galaxy',
                  subtitle: 'only 2 stock',
                  productImage: AppImages.galaxyS24,
                ),
                ProductGrid(
                  productName: 'Iphone 13',
                  subtitle: 'only 2 stock',
                  productImage: AppImages.iphone13pro,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Laptops',
                style: categoryTitle,
              ),
              TextButton(onPressed: () {}, child: const Text('See All')),
            ],
          ),
          SizedBox(
            height: size.height * .25,
            width: size.width,
            child: GridView.count(
              crossAxisCount: 1,
              scrollDirection: Axis.horizontal,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 3 / 3,
              children: [
                ProductGrid(
                  productName: 'Asus rogue',
                  subtitle: 'only 2 stock',
                  productImage: AppImages.asusRogue,
                ),
                ProductGrid(
                  productName: 'Asus rogue',
                  subtitle: 'only 2 stock',
                  productImage: AppImages.asusRogue,
                ),
                ProductGrid(
                  productName: 'Asus rogue',
                  subtitle: 'only 2 stock',
                  productImage: AppImages.asusRogue,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

