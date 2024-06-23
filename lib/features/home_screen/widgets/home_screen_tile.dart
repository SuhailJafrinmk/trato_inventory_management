import 'package:flutter/material.dart';

class HomeScreenTile extends StatelessWidget {
  final String contentType;
  void Function()? onPressed;
 HomeScreenTile({super.key, required this.contentType,this.onPressed});
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        padding: EdgeInsets.all(15),
        height: height*.08,
        // width: width*.8,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 188, 198, 215),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(),
                SizedBox(width: 20,),
                Text(contentType,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
              ],
            ),
            IconButton(onPressed: onPressed, icon: Icon(Icons.arrow_forward_ios)),
          ],
        ),
      ),
    );
  }
}