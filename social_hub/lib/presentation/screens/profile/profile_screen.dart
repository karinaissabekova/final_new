import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../cubit/auth/auth_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Icon(Icons.person, size: 80),

          const SizedBox(height: 10),

          Text(user?.email ?? "No email"),

          const SizedBox(height: 20),

          TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: "Username",
            ),
          ),

          const SizedBox(height: 10),

          ElevatedButton.icon(
            icon: const Icon(Icons.save),
            label: const Text("Save name"),
            onPressed: () {
              user?.updateDisplayName(controller.text);
            },
          ),

          const SizedBox(height: 20),

          ElevatedButton.icon(
            icon: const Icon(Icons.logout),
            label: const Text("Logout"),
            onPressed: () {
              context.read<AuthCubit>().logout();
            },
          ),
        ],
      ),
    );
  }
}