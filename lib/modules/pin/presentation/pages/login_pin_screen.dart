import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/core/utils/local_values.dart';
import 'package:product_app/modules/auth/presentation/pages/home_screen.dart';
import 'package:product_app/modules/pin/domain/entities/login_pin_entity.dart';
import 'package:product_app/modules/product_management/presentation/pages/product_screen.dart';

import '../../../../core/utils/snackbar_message.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/pin_bloc.dart';

class LoginPinScreen extends StatefulWidget {
  const LoginPinScreen({super.key});

  @override
  State<LoginPinScreen> createState() => _LoginPinScreenState();
}

class _LoginPinScreenState extends State<LoginPinScreen> {
  final _pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login with your pin'),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _pinController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Entter your pin',
                labelText: 'Pin',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<PinBloc, PinState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return const Center(
                    child: LoadingWidget(),
                  );
                } else {
                  return ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<PinBloc>(context).add(LoginPinEvent(
                            loginPinEntity:
                                LoginPinEntity(pin: _pinController.text)));
                      },
                      child: const Text('Login Pin'));
                }
              },
              listener: (context, state) {
                if (state is ErrorPinState) {
                  SnackBarMessage().showErrorSnackBar(
                      message: state.message, context: context);
                }
                if (state is LoginPinState) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const ProductPage(),
                  ));
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () async {
                await LocalValues.clearPin();
                if (context.mounted) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                }
              },
              child: const Text('Reset Pin'),
            ),
          ],
        ),
      ),
    );
  }
}
