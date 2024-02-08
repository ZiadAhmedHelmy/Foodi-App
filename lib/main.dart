import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:providerapp/firebase_options.dart';
import 'package:providerapp/splashScreen.dart';
import 'package:providerapp/viewModel/Bloc/BottomNavigationCubit/NavigationBloc.dart';
import 'package:providerapp/viewModel/Bloc/ButtonCounterCubit/button_counter_cubit.dart';
import 'package:providerapp/viewModel/Bloc/Observer.dart';
import 'package:providerapp/viewModel/Bloc/UserProfile/profile_cubit.dart';
import 'package:providerapp/viewModel/Bloc/auth/auth_cubit_bloc.dart';
import 'package:providerapp/viewModel/Bloc/order/order_cubit_bloc.dart';
import 'package:providerapp/viewModel/Bloc/product/product_cubit_bloc.dart';
import 'package:providerapp/viewModel/data/SharedKeys.dart';
import 'package:providerapp/viewModel/data/SharedPrefrences.dart';
import 'viewModel/Bloc/Categories/category_cubit_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  LocalData.init();
  // LocalData.clearData();
  runApp(
    const MyApp(), // Wrap your app
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => ProductCubit(),
        ),
        BlocProvider(
          create: (context) => NavigationCubit(),
        ),
        BlocProvider(
          create: (context) => OrderCubit(),
        ),
        BlocProvider(
          create: (context) => ButtonCounterCubit(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Rubik'),
        home: const SplashScreen(),
      ),
    );
  }
}
