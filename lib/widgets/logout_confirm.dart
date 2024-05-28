import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/profile/bloc/profile_bloc.dart';

class LogoutConfirmModal extends StatelessWidget {
  const LogoutConfirmModal({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc=BlocProvider.of<ProfileBloc>(context);
    return AlertDialog(
      title: Text('Confirm'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('are you sure you want to logout'),
          ElevatedButton(onPressed: (){
            bloc.add(LogoutTilePressed());
          }, child: Text('Logout'))
          ],
      ),
    );
  }
}