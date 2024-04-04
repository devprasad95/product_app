import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/core/pages/loading_screen.dart';
import 'package:product_app/injection_container.dart' as di;
import 'package:product_app/modules/auth/presentation/bloc/auth_bloc.dart';
import 'package:product_app/modules/auth/presentation/pages/home_screen.dart';
import 'package:product_app/modules/auth/presentation/pages/sign_in_screen.dart';
import 'package:product_app/modules/pin/presentation/bloc/pin_bloc.dart';
import 'package:product_app/modules/product_management/presentation/bloc/product_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthBloc>()),
        BlocProvider(create: (_) => di.sl<PinBloc>()),
        BlocProvider(
          create: (_) => di.sl<ProductBloc>()..add(ProductListEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            print(state);
            if (state is AuthSignedInState) {
              return const HomeScreen();
            } else if (state is AuthLoggedOutState) {
              return const SignInScreen();
            } else if (state is AuthLoadingState) {
              return const LoadingScreen();
            } else if(state is AuthSignedUpState){
              return const SignInScreen();
            }
            else {
              return const SignInScreen();
            }
          
          },
        ),
      ),
    );
  }
}
