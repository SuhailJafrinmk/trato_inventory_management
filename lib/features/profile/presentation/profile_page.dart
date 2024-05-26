import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/profile/bloc/profile_bloc.dart';
import 'package:trato_inventory_management/utils/constants/image_links.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProfileBloc>(context);
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
       if(state is LogoutSuccess){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logging out')));
        Navigator.pushReplacementNamed(context, 'login');
       }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: DottedBorder(
                borderType: BorderType.Circle,
                child: const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(AppImages.shopDummyimage), 
                ),
              ),
            ),
            const Text(
              '6g mobiles',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Gst id:1212121212',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Edit Profile'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
           
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              trailing: Switch(
                value: true, 
                onChanged: (value) {
                  
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                bloc.add(LogoutTilePressed());
              },
            ),
          ],
        ),
      ),
    );
  }
}
