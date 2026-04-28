class Post {
  final String id;
  final String content;
  final String username;
  final int likes;
  final List likedBy;

  Post({
    required this.id,
    required this.content,
    required this.username,
    required this.likes,
    required this.likedBy,
  });

  factory Post.fromMap(Map<String, dynamic> map, String id) {
    return Post(
      id: id,
      content: map['content'] ?? '',
      username: map['username'] ?? '',
      likes: map['likes'] ?? 0,
      likedBy: map['likedBy'] ?? [],
    );
  }
}