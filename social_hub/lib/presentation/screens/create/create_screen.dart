import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../cubit/post/post_cubit.dart';

class CreateScreen extends StatelessWidget {
  CreateScreen({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: "Write something...",
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton.icon(
            icon: const Icon(Icons.send),
            label: const Text("Post"),
            onPressed: () {
              context.read<PostCubit>().createPost(
                    controller.text,
                    user?.displayName ?? user?.email ?? "User",
                  );

              controller.clear();
            },
          ),
        ],
      ),
    );
  }
}