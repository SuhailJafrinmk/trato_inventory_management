import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/image_links.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(child: Column(
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
          CarouselContainer(data: '23232', datatype: 'total stock', imageurl:AppImages.shopDummyimage),
           CarouselContainer(data: '2323', datatype: 'total Products', imageurl:AppImages.shopDummyimage),
            CarouselContainer(data: '2323s2', datatype: 'total sales', imageurl:AppImages.shopDummyimage),
        ], options: CarouselOptions(
          autoPlay: true
        )),
        SizedBox(height:size.height*.03,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('SmartPhones',style:categoryTitle ,),
            TextButton(onPressed: (){}, child: const Text('See All')),
          ],
        ),
        // GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: ), itemBuilder: itemBuilder)
        ],
      )
      ),
    );
  }
}