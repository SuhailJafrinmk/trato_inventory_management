import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductGrid extends StatelessWidget {
   void Function()? onTap;
   final String productName;
   final String subtitle;
   final String productImage;
   final String subtitleTwo;
   ProductGrid({required this.productName,required this.subtitle,required this.productImage,this.onTap,required this.subtitleTwo});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: const Border(
              left: BorderSide(color: Colors.black12, width: 2.0),
              right: BorderSide(color: Colors.black12, width: 2.0),
              bottom: BorderSide(color: Colors.black12, width: 2.0),
            )
          ),
          child: SizedBox(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image:  DecorationImage(
                        image: NetworkImage(productImage),
                        fit: BoxFit.cover,
                      ),
                       borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
                    ),
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        style: const TextStyle(fontWeight: FontWeight.bold),   
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(color: Colors.black45),
                      ),
                      Text(
                        subtitleTwo,
                        style: const TextStyle(color: Colors.black45),

                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}