import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
import 'core/app_settings.dart';

import 'presentation/cubit/auth/auth_cubit.dart';
import 'presentation/cubit/post/post_cubit.dart';
import 'presentation/cubit/api/api_cubit.dart';

import 'presentation/screens/auth/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await AppSettings.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void rebuild(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()?.setState(() {});
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => PostCubit()..loadPosts()),
        BlocProvider(create: (_) => ApiCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppSettings.isDark ? ThemeData.dark() : ThemeData.light(),
        home: const AuthScreen(),
      ),
    );
  }
}
