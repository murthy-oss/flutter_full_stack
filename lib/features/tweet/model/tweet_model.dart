import 'dart:convert';

class TweetModel {
  final String tweetid;
  final String content;
  final DateTime createdAt;
  final String adminId;

  TweetModel({
    required this.tweetid, 
    required this.content, 
    required this.createdAt,
    required this.adminId
  });

  Map<String, dynamic> toMap() {
    return {
      'tweetid': tweetid,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'adminId': adminId,
    };
  }

  factory TweetModel.fromMap(Map<String, dynamic> map) {
    return TweetModel(
      tweetid: (map['tweetid'] ?? '') as String, // Null check first, then cast
      content: (map['content'] ?? '') as String, // Null check first, then cast
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(), // Handle null with fallback
      adminId: (map['adminId'] ?? '') as String // Null check first, then cast
    );
  }

  String toJson() => json.encode(toMap());

  factory TweetModel.fromJson(String source) => TweetModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
