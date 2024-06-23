import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/addproduct/bloc/add_product_bloc.dart';
import 'package:trato_inventory_management/features/addpurchase/bloc/add_purchase_bloc.dart';
import 'package:trato_inventory_management/features/addsales/bloc/add_sales_bloc.dart';
import 'package:trato_inventory_management/features/addstore/bloc/addstore_bloc.dart';
import 'package:trato_inventory_management/features/home_screen/bloc/home_screen_bloc.dart';
import 'package:trato_inventory_management/features/inventory/bloc/inventory_bloc.dart';
import 'package:trato_inventory_management/features/login/bloc/login_bloc.dart';
import 'package:trato_inventory_management/features/login/cubit/obscure_cubit.dart';
import 'package:trato_inventory_management/features/profile/bloc/profile_bloc.dart';
import 'package:trato_inventory_management/features/purchases/bloc/purchase_bloc.dart';
import 'package:trato_inventory_management/features/records/bloc/records_page_bloc.dart';
import 'package:trato_inventory_management/features/register/bloc/register_bloc.dart';
import 'package:trato_inventory_management/features/sales/bloc/sales_bloc.dart';
import 'package:trato_inventory_management/features/splash_screen/splash_screen.dart';
import 'package:trato_inventory_management/firebase_options.dart';
import 'package:trato_inventory_management/utils/check_connectivity.dart/cubit/connectivity_cubit.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/routes/routes.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => LoginBloc(),
      ),
      BlocProvider(
        create: (context) => RegisterBloc(),
      ),
      BlocProvider(
        create: (context) => ProfileBloc(),
      ),
      BlocProvider(
        create: (context) => AddstoreBloc(),
      ),
      BlocProvider(
        create: (context) => InventoryBloc(),
      ),
      BlocProvider(
        create: (context) => AddProductBloc(),
      ),
      BlocProvider(
        create: (context) => AddPurchaseBloc(),
      ),
      BlocProvider(
        create: (context) => PurchaseBloc(),
      ),
      BlocProvider(
        create: (context) => AddSalesBloc(),
      ),
      BlocProvider(
        create: (context) => SalesBloc(),
      ),
      BlocProvider(
        create: (context) => HomeScreenBloc(),
      ),
      BlocProvider(
        create: (context) => RecordsPageBloc(),
      ),
      BlocProvider(
        create: (context) => ObscureCubit(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConnectivityCubit()..trackConnectivityChange(),
      child: BlocListener<ConnectivityCubit, InternetStatus>(
        listener: (context, state) {
          if(state.status==ConnectivityStatus.disconnected){
            _showNoConnectionDialog();
          }else{
            _dismissNoConnectionDialog();
          }
        },
        child: MaterialApp(
          navigatorKey: navigatorKey,
          routes: AppRoutes.approutes,
          theme: ThemeData(
            appBarTheme:
                const AppBarTheme(backgroundColor: AppColors.backgroundColor),
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        ),
      ),
    );
  }

  void _showNoConnectionDialog() {
    final context = navigatorKey.currentState?.overlay?.context;
    if (context != null) {
      showDialog(
        context: context,
        barrierDismissible: false, 
        builder: (context) => WillPopScope(
          onWillPop: () async => false, 
          child: AlertDialog(
            title: Text('No Connection'),
            content: Text('You are not connected to the internet.'),
            actions: [
              TextButton(
                onPressed: () {},
                child: Text('OK'),
              ),
            ],
          ),
        ),
      );
    }
  }
    void _dismissNoConnectionDialog() {
    if (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState?.pop();
    }
  }
}
