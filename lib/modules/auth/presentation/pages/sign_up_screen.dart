import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/core/widgets/loading_widget.dart';
import 'package:product_app/modules/auth/domain/entities/sign_up_entity.dart';
import 'package:product_app/modules/auth/presentation/bloc/auth_bloc.dart';
import 'package:product_app/modules/auth/presentation/pages/sign_in_screen.dart';

import '../../../../core/utils/snackbar_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Please enter your Email',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                hintText: 'Please enter your Password',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoadingState) {
                  return const LoadingWidget();
                } else {
                  return ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(
                        SignUpEvent(
                          signUpEntity: SignUpEntity(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            confirmPassword: '',
                          ),
                        ),
                      );
                    },
                    child: const Text('Sign Up'),
                  );
                }
              },
              listener: (context, state) {
                if (state is AuthSignedUpState) {
                  _emailController.clear;
                  _passwordController.clear;
                  SnackBarMessage().showSuccessSnackBar(
                      message:
                          'Created new account, go back and login with your credentials',
                      context: context);
                }
                if (state is AuthErrorState) {
                  SnackBarMessage().showErrorSnackBar(
                    message: state.message,
                    context: context,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
