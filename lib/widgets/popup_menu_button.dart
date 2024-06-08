
// import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
// import 'package:flutter/material.dart';
// import 'package:trato_inventory_management/features/addproduct/presentation/add_product.dart';
// import 'package:trato_inventory_management/features/editproduct/presentation/edit_product.dart';
// import 'package:trato_inventory_management/widgets/delete_confirm_modal.dart';

// class CustomPopupMenuWidget extends StatelessWidget {
//   final List<String> menuItems;
//   final CustomPopupMenuController controller;
//   final Widget child;
//   final Map<String,dynamic>? document;

//   CustomPopupMenuWidget({required this.menuItems,required this.controller,required this.child,this.document});

//   @override
//   Widget build(BuildContext context) {
//     return CustomPopupMenu(
//       child: child,
//       menuBuilder: () => ClipRRect(
//         borderRadius: BorderRadius.circular(5),
//         child: Container(
//           color: const Color(0xFF4C4C4C),
//           child: IntrinsicWidth(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: menuItems.map(
//                 (item) {
//                   return GestureDetector(
//                     behavior: HitTestBehavior.translucent,
//                     onTap: () {
//                       print("onTap");
//                        _onMenuItemSelected(context, item,document);
//                       controller.hideMenu();    
//                     },
//                     child: Container(
//                       height: 40,
//                       padding: EdgeInsets.symmetric(horizontal: 20),
//                       child: Row(
//                         children: <Widget>[
//                           Expanded(
//                             child: Container(
//                               margin: EdgeInsets.only(left: 10),
//                               padding: EdgeInsets.symmetric(vertical: 10),
//                               child: Text(
//                                 item,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ).toList(),
//             ),
//           ),
//         ),
//       ),
//       pressType: PressType.singleClick,
//       verticalMargin: -10,
//       controller: controller,
//     );
//   }
// }

// void _onMenuItemSelected(BuildContext context, String item,Map<String,dynamic>?document) {
//     switch (item) {
//       case 'Delete':
//        deleteConfirmationModal(context,document);
//         break;
//       case 'Edit':
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => EditProduct()),
//         );
//         break;
//       default:
//         print('Unknown menu item: $item');
//     }
//   }
// void deleteConfirmationModal(BuildContext context,Map<String,dynamic>?document){
// showDialog(context: context, builder: (context){
//   return DeleteConfirmationModal();
// });
// }