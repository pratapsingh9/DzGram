import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Data model for a comment
class Comment {
  final String username;
  final String comment;
  final String profileImageUrl;
  final String timeAgo;

  Comment({
    required this.username,
    required this.comment,
    required this.profileImageUrl,
    required this.timeAgo,
  });
}

// Sample data
final List<Comment> comments = [
  Comment(
    username: 'john_doe',
    comment: 'Great post! Really enjoyed this one.',
    profileImageUrl: 'https://example.com/profile1.jpg',
    timeAgo: '2h',
  ),
  Comment(
    username: 'jane_smith',
    comment: 'Thanks for sharing!',
    profileImageUrl: 'https://example.com/profile2.jpg',
    timeAgo: '4h',
  ),
  Comment(
    username: 'susan_lee',
    comment: 'Amazing picture!',
    profileImageUrl: 'https://example.com/profile3.jpg',
    timeAgo: '1d',
  ),
  // Add more comments as needed
];

class CommentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Comments', style: TextStyle(color: Colors.white)),
      ),
      body: comments.isEmpty
          ? const Center(
              child: Text(
                "No comments yet. Start the conversation!",
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return CommentWidget(comment: comment);
              },
            ),
      backgroundColor: Colors.black,
    );
  }
}

class CommentWidget extends StatelessWidget {
  final Comment comment;

  const CommentWidget({required this.comment, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(comment.profileImageUrl),
            radius: 20.0,
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.username,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    Text(
                      comment.timeAgo,
                      style: GoogleFonts.roboto(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  comment.comment,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3, // Limit text to 3 lines
                ),
                const SizedBox(height: 8.0),
               
              ],
            ),
          ),
          Icon(Icons.favorite_outline , color: Colors.white,)
        ],
      ),
    );
  }
}
