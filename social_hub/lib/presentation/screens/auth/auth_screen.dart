import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_hub/lang.dart';

import '../../../core/app_settings.dart';

import '../../cubit/auth/auth_cubit.dart';
import '../home/home_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? AppLang.t("login") : AppLang.t("register")),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            onSelected: (value) {
              AppSettings.lang = value;

              /// 🔥 ПЕРЕЗАГРУЗКА ЭКРАНА (без ошибок)
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const AuthScreen()),
              );
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: "en", child: Text("English")),
              PopupMenuItem(value: "ru", child: Text("Русский")),
              PopupMenuItem(value: "kz", child: Text("Қазақша")),
            ],
          ),
        ],
      ),

      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          }

          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: AppLang.t("email")),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: AppLang.t("password"),
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();

                      if (isLogin) {
                        context.read<AuthCubit>().login(email, password);
                      } else {
                        context.read<AuthCubit>().register(email, password);
                      }
                    },
                    child: Text(
                      isLogin ? AppLang.t("login") : AppLang.t("register"),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(
                      isLogin ? AppLang.t("register") : AppLang.t("login"),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
