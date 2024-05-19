import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';

class CarouselContainer extends StatelessWidget {
  final String data;
  final String datatype;
  final String imageurl;

  const CarouselContainer({super.key, required this.data, required this.datatype,required this.imageurl});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Card(
      child: Row(
        children: [
          Container(
            // color: Colors.red,
          height: size.height*.2,
          width: size.width*.5,
          
          child: Column(
            children: [
              SizedBox(height: size.height*.05,),
              Text(data,style: carouselTextLarge,),
              Text(datatype,style: carouselTextLarge,),
            ],
          ),
        ),
        Expanded(child: Image.asset(imageurl,fit: BoxFit.cover,)),
        ],
        
      )
    );
  }
}