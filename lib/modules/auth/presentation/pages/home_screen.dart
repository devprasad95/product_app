import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/core/utils/local_values.dart';
import 'package:product_app/core/widgets/loading_widget.dart';
import 'package:product_app/modules/pin/presentation/pages/create_pin_screen.dart';
import 'package:product_app/modules/pin/presentation/pages/login_pin_screen.dart';

import '../bloc/auth_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    LocalValues.init();
    Future.delayed(
      const Duration(seconds: 3),
      () async{
        
         String? pin = await LocalValues.getPin();
         print( 'Pin $pin');
        if (pin != null) {
          if (!mounted) return;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LoginPinScreen(),
            ),
          );
        } else {
          if (!mounted) return;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const CreatePinScreen(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: Center(
        child: LoadingWidget(),
      ),
    );
  }
}
