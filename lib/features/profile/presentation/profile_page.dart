import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/addstore/presentation/add_store.dart';
import 'package:trato_inventory_management/features/profile/bloc/profile_bloc.dart';
import 'package:trato_inventory_management/utils/constants/image_links.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/logout_confirm.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
   Map<String,dynamic>? storeDetails;
  @override
  void initState() {
    BlocProvider.of<ProfileBloc>(context).add(FetchStoreDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProfileBloc>(context);
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Logging out')));
          Navigator.pushReplacementNamed(context, 'login');
        }
        if(state is FetchedStoreDetails){
          storeDetails=state.data;
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
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is FetchedStoreDetails) {
                  return Text('${state.data['storeName']}',style: categoryTitle,);
                }
                return Text(
                  'Not available',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                );
              },
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if(state is FetchedStoreDetails){
                  return Text('GST ID : ${state.data['gstId']}');
                }
                return Text(
                  'Gst id:1212121212',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                );
              },
            ),
            const SizedBox(height: 20),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Edit Profile'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddStorePage(storeDetails: storeDetails,)));
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              trailing: Switch(
                value: true,
                onChanged: (value) {},
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                showLogoutConfirmPopup(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

void showLogoutConfirmPopup(BuildContext context) {
  showDialog(context: context, builder: (context) => LogoutConfirmModal());
}
