import 'package:flutter/material.dart';
import 'package:product_app/core/widgets/loading_widget.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: LoadingWidget(),),);
  }
}