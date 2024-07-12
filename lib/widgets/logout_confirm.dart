import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/profile/bloc/profile_bloc.dart';

class LogoutConfirmModal extends StatelessWidget {
  const LogoutConfirmModal({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc=BlocProvider.of<ProfileBloc>(context);
    return AlertDialog(
            title: const AutoSizeText('Logout'),
            content: const SingleChildScrollView(
              child: ListBody(
                children:  <Widget>[
                  AutoSizeText('Are you sure, do you want to logout?'),
                ],
              ),
            ),
            actions: <Widget>[
                TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  bloc.add(LogoutTilePressed());
                },
              ),
            ],
          );
     
  }
}
