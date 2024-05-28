import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/image_links.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales records'),
      ),
      body: Expanded(child: Container(
        child: ListView(
          children:const [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(AppImages.recordsSales),
              ),
              title: Text('Purchase 121'),
              subtitle: Text('Amount:1212 \$'),
              trailing: Text('01/12/2024'),
            ),
              ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(AppImages.recordsSales),
              ),
              title: Text('Purchase 121'),
              subtitle: Text('Amount:1212 \$'),
              trailing: Text('01/12/2024'),
            ),
              ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(AppImages.recordsSales),
              ),
              title: Text('Purchase 121'),
              subtitle: Text('Amount:1212 \$'),
              trailing: Text('01/12/2024'),
            ),
          ],
        ),
      )),
    );
  }
}