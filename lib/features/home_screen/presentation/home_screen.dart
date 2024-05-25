import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trato_inventory_management/features/addproduct/presentation/add_product.dart';
import 'package:trato_inventory_management/features/addstore/presentation/add_store.dart';
import 'package:trato_inventory_management/features/customer/presentation/customer_page.dart';
import 'package:trato_inventory_management/features/inventory/presentation/inventory_page.dart';
import 'package:trato_inventory_management/features/product_details/presentation/product_details.dart';
import 'package:trato_inventory_management/features/profile/presentation/profile_page.dart';
import 'package:trato_inventory_management/features/purchases/presentation/purchases.dart';
import 'package:trato_inventory_management/features/records/presentation/records.dart';
import 'package:trato_inventory_management/features/supplier/presentation/supplier.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/image_links.dart';
import 'package:trato_inventory_management/utils/constants/navigation_items_list.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/bottom_navigation.dart';
import 'package:trato_inventory_management/widgets/carousel_slider.dart';
import 'package:trato_inventory_management/widgets/product_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController=PageController();
  int selectedIndex=0;
  final List<String> AppbarTitles=['Home','Inventory','Records',"profile"];
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
         onItemTapped: (index){
          setState(() {
            selectedIndex=index;
            pageController.jumpToPage(index);
          });
         }),
         body: PageView(
          controller: pageController,
          onPageChanged: (value) {
            setState(() {
              selectedIndex=value;
            });
          },
          children: [
            HomeFirst(),
            InventoryPage(),
            Records(),
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
     final size=MediaQuery.of(context).size;
    return SafeArea(child: SingleChildScrollView(
      child: Column(
          children: [
            SizedBox(height: size.height*.03,),
           Material(
            elevation: 5,
             child: ListTile(leading: 
             SizedBox(child: Image.asset(AppImages.shopDummyimage)),
             title:const Text('Indian Hyper market'),subtitle: const Text('Gst id:232323232'),),
           ),
           SizedBox(height:size.height*.03,),
          CarouselSlider(items: const[
            CarouselContainer(data: 'Total Costs', datatype: '10000 \$', imageurl:AppImages.costsImage),
             CarouselContainer(data: 'Total Stock', datatype: '10000 \$', imageurl:AppImages.salesImage),
              CarouselContainer(data: 'Total Sales', datatype: '10000 \$', imageurl:AppImages.stockImage),
          ], options: CarouselOptions(
            autoPlay: true
          )),
          SizedBox(height:size.height*.03,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Smartphones',style:categoryTitle ,),
              TextButton(onPressed: (){}, child: const Text('See All')),
            ],
          ),
          SizedBox(
            height: size.height*.25,
            width: size.width,
            child: GridView.count(crossAxisCount: 1,
          scrollDirection: Axis.horizontal,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 3 / 3,
          children: [
         ProductGrid(productName: 'Pixel 7A', subtitle: 'only 2 stock',productImage: AppImages.pixelImage,),
         ProductGrid(productName: 'Samsung galaxy', subtitle: 'only 2 stock',productImage: AppImages.galaxyS24,),
         ProductGrid(productName: 'Iphone 13', subtitle: 'only 2 stock',productImage: AppImages.iphone13pro,),
          ],
          ),
          ),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Laptops',style:categoryTitle ,),
              TextButton(onPressed: (){}, child: const Text('See All')),
            ],
          ),
           SizedBox(
            height: size.height*.25,
            width: size.width,
            child: GridView.count(crossAxisCount: 1,
          scrollDirection: Axis.horizontal,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 3 / 3,
          children: [
         ProductGrid(productName: 'Asus rogue', subtitle: 'only 2 stock',productImage: AppImages.asusRogue,),
         ProductGrid(productName: 'Asus rogue', subtitle: 'only 2 stock',productImage: AppImages.asusRogue,),
         ProductGrid(productName: 'Asus rogue', subtitle: 'only 2 stock',productImage: AppImages.asusRogue,),
          ],
          ),
          ),
          
          ],
        ),
    )
      );
  }
}