import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';

class RecordsAddTile extends StatelessWidget {
  final String backgroundImage;
  final String title;
  void Function()? onTapAdd;
  void Function()? onTapView;

  RecordsAddTile(
      {super.key,
      required this.backgroundImage,
      required this.title,
      this.onTapAdd,
      this.onTapView});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Material(
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
      elevation: 20,
      child: Container(
        padding: const EdgeInsets.all(10),
        height: height * .2,
        width: width * .8,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
          color: AppColors.backgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(backgroundImage),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  AutoSizeText(
                    title,
                    style: categoryTitle,
                    maxLines: 1,
                  ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: onTapView, child: const AutoSizeText('view')),
                        ElevatedButton(onPressed: onTapAdd, child: const AutoSizeText('Add')),
                      ],
                    )
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
