import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HomeScreenTile extends StatelessWidget {
  final String contentType;
  void Function()? onPressed;
 HomeScreenTile({super.key, required this.contentType,this.onPressed});
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        padding: const EdgeInsets.all(15),
        height: height*.08,
        // width: width*.8,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 188, 198, 215),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(),
                const SizedBox(width: 20,),
                AutoSizeText(contentType,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
              ],
            ),
            IconButton(onPressed: onPressed, icon: const Icon(Icons.arrow_forward_ios)),
          ],
        ),
      ),
    );
  }
}