import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/image_links.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/app_textfield.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';
import 'package:trato_inventory_management/widgets/product_grid.dart';
import 'package:trato_inventory_management/widgets/product_quantity_select_modal.dart';


class AddPurchase extends StatefulWidget {
  const AddPurchase({super.key});

  @override
  State<AddPurchase> createState() => _AddPurchaseState();
}

class _AddPurchaseState extends State<AddPurchase> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    String selected_item='mobile tech';
     print('width of device:$width');
     print('height of device:$height');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Purchase'),
      ),
      body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
                    children: [
                 
                   const SizedBox(height: 20,),
                 SizedBox(
          height: height*.4,
          width: width,
          child: GridView.count(
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        childAspectRatio: 2 / 3,
        children: [
          ProductGrid(productName: 'samsung galaxy', subtitle: 'samsung electronics', productImage:AppImages.galaxyS24,onTap: () => showQuantityModal(context, 'samsung galaxy'),),
          ProductGrid(productName: 'Iphone 13 pro', subtitle: 'Apple electronics', productImage:AppImages.iphone13pro,onTap: () => showQuantityModal(context, 'iphone 13 pro', ),),
          ProductGrid(productName: 'pixel 7a', subtitle: 'google electronics', productImage:AppImages.pixelImage,onTap: () => showQuantityModal(context, 'pixel 7a'),),
          ProductGrid(productName: 'Asus rogue', subtitle: 'Asus electronics', productImage:AppImages.asusRogue,onTap: () => showQuantityModal(context, 'asus rogue'),),
          ProductGrid(productName: 'Redmi 9a', subtitle: 'Shaomi mobiles', productImage:AppImages.redmi9a,onTap: () => showQuantityModal(context, 'Redmi 9a'),),
        ],
        ),
        ),
        Expanded(child: Container(
          width: width,
          decoration: BoxDecoration(
            border: Border.all()
          ),
          child: Column(
            children: [
              Text('Grand totel:\$ 343434',style: biggestTextBlack,),
              const SizedBox(height: 20,),
              SizedBox(
                height: height*.3,
                width: width,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: const[
                   ListTile(
                    title: Text('samsung galaxy'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('quanity:120'),
                        Text('supplier:samsung mobiles'),
                      ],
                    ),
                    trailing: Icon(Icons.delete),
                  ),
                    ListTile(
                    title: Text('pixel 7a'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('quanity:50'),
                        Text('supplier:google electronic'),
                      ],
                    ),
                    trailing: Icon(Icons.delete),
                  ),
                     ListTile(
                    title: Text('Asus rogue'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('quanity:70'),
                        Text('supplier:Asus electronics'),
                      ],
                    ),
                    trailing: Icon(Icons.delete),
                  ),
                  
                  ],
                ),
              ),
              Expanded(child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [ElevatedButton(onPressed: (){
                    showCustomerForm(context);
                  }, child: const Text('Add')),
                  ElevatedButton(onPressed: (){}, child: const Text('cancel'))
                  ],
                ),
              ))
            ],
          ),
        ))
                    ],
                  ),
          )
          ),
    );
  }
}
void showQuantityModal(BuildContext context,String productName,){
  showDialog(context: context,
   builder: (context){
    return QuantityModal(productName: productName);
   }
   );
}

void showCustomerForm(BuildContext context){
  showModalBottomSheet(context: context,
   builder: (context){
    return Container(
      padding: EdgeInsets.all(20),
      
      child: Column(
        children: [
          AppTextfield(labelText: 'Customer name', width: double.infinity, padding: 10, obscureText: false,fillColor: Colors.white,),
          AppTextfield(labelText: 'Customer email', width: double.infinity, padding: 10, obscureText: false,fillColor: Colors.white,),
          CustomButton(height: 60, width: double.infinity, elevation: 10, color: AppColors.primaryColor, radius: 10,child: Text('Confirm',style: buttonText,),)
        ],
      ),
    );
   }
   );
}
