import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_hub/lang.dart';

import '../../../data/models/post_model.dart';
import '../../cubit/post/post_cubit.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return BlocBuilder<PostCubit, List<Post>>(
      builder: (context, posts) {
        if (posts.isEmpty) {
          return Center(
            child: Text(
              AppLang.t("no_posts"),
              style: const TextStyle(fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            final isLiked = post.likedBy.contains(userId);

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// 👤 USER
                      Row(
                        children: [
                          const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            post.username,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      /// 📝 TEXT
                      Text(
                        post.content,
                        style: const TextStyle(fontSize: 16),
                      ),

                      const SizedBox(height: 12),

                      /// ❤️ LIKE
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.favorite,
                                color: isLiked
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                              const SizedBox(width: 6),
                              Text("${post.likes}"),
                            ],
                          ),

                          /// 🔥 АНИМАЦИЯ ЛАЙКА
                          AnimatedScale(
                            scale: isLiked ? 1.2 : 1,
                            duration:
                                const Duration(milliseconds: 200),
                            child: IconButton(
                              icon: Icon(
                                isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isLiked
                                    ? Colors.red
                                    : null,
                              ),
                              onPressed: () {
                                context
                                    .read<PostCubit>()
                                    .toggleLike(
                                      post.id,
                                      post.likedBy,
                                    );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}