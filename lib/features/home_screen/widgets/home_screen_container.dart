
import 'dart:developer' as developer;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';


class HomeScreenContainer extends StatelessWidget {
 final String data;
 final String title;

  HomeScreenContainer({super.key, required this.data, required this.title});

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    developer.log(' 4.2 height of device is $height and width of device is $width and height=${height*.2}');
    return Container(
      height: height * .16,
      width: width * .42,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 57, 103, 98),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(),
            Spacer(),
            AutoSizeText(data,style:TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold) ,),
            // Text(data,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
            AutoSizeText(title,style: TextStyle(color: Colors.white),),
          ],
        ),
      ),
    );
  }
}