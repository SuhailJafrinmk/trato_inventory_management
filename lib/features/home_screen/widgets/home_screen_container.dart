
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';


class HomeScreenContainer extends StatelessWidget {
 final String data;
 final String title;
 final String backgroundImage;
  HomeScreenContainer({super.key, required this.data, required this.title,required this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Container(
      height: height * .16,
      width: width * .42,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 57, 103, 98),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(backgroundImage),
            ),
            const Spacer(),
            AutoSizeText(data,style:const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,),
            AutoSizeText(title,style: const TextStyle(color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,),
          ],
        ),
      ),
    );
  }
}