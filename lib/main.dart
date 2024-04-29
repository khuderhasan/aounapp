import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'config/constants.dart';
import 'config/routs.dart';
import 'data/datasources/auth_datasource.dart';
import 'data/datasources/products_datasource.dart';
import 'data/datasources/stores_datasource.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/products_repository.dart';
import 'data/repositories/stores_repository.dart';
import 'firebase_options.dart';
import 'presentation/cubits/auth_cubit/auth_cubit.dart';
import 'presentation/cubits/products_cubit/products_cubit.dart';
import 'presentation/cubits/stores/stores_cubit.dart';
import 'presentation/screens/signup/signup_screen.dart';
import 'presentation/screens/splash_screen.dart';
import 'providers/current_store_provider.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CurrentStoreProvider>(
      create: (context) => CurrentStoreProvider(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(
                authRepository: AuthRepository(dataSource: AuthDataSource())),
          ),
          BlocProvider<ProductsCubit>(
              create: (context) => ProductsCubit(
                  repository:
                      ProductsRepository(dataSource: ProductsDatasource()))),
          BlocProvider<StoresCubit>(
              create: (context) => StoresCubit(
                  repository:
                      SotresRepository(datasource: StoresDatasource()))),
        ],
        child: MaterialApp(
          title: 'Aoun App',
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          routes: routes,
          home: AnimatedSplashScreen(
            splashIconSize: 600,
            centered: true,
            splash: const SplashScreen(),
            nextScreen: const SignUpScreen(),
          ),
        ),
      ),
    );
  }
}
