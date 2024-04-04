import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/core/utils/snackbar_message.dart';
import 'package:product_app/core/widgets/loading_widget.dart';
import 'package:product_app/modules/auth/domain/entities/sign_in_entity.dart';
import 'package:product_app/modules/auth/presentation/pages/home_screen.dart';
import 'package:product_app/modules/auth/presentation/pages/sign_up_screen.dart';

import '../bloc/auth_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
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
                        SignInEvent(
                          signInEntity: SignInEntity(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          ),
                        ),
                      );
                    },
                    child: const Text('Sign In'),
                  );
                }
              },
              listener: (context, state) {
                if (state is AuthSignedInState) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                }
                if(state is AuthErrorState){
                  SnackBarMessage().showErrorSnackBar(message: state.message, context: context);
                }
              },
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  );
                },
                child: const Text('Register'))
          ],
        ),
      ),
    );
  }
}
