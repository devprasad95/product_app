import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/core/utils/snackbar_message.dart';
import 'package:product_app/core/widgets/loading_widget.dart';
import 'package:product_app/modules/auth/presentation/pages/home_screen.dart';
import 'package:product_app/modules/pin/presentation/bloc/pin_bloc.dart';

import '../../domain/entities/create_pin_entity.dart';

class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({super.key});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Create a new pin'),
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
            TextField(
              controller: _confirmPinController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Entter your pin',
                labelText: 'Confirm Pin',
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
                        BlocProvider.of<PinBloc>(context).add(CreatePinEvent(
                            createPinEntity: CreatePinEntity(
                                pin: _pinController.text,
                                confirmPin: _confirmPinController.text)));
                      },
                      child: const Text('Create Pin'));
                }
              },
              listener: (context, state) {
                if (state is ErrorPinState) {
                  SnackBarMessage().showErrorSnackBar(
                      message: state.message, context: context);
                }
                if (state is CreatePinState) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
