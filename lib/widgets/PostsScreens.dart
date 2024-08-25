import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Posts extends StatelessWidget {
  final String usernameurl;
  final String username;
  final String imageurl;

  const Posts({
    super.key,
    required this.usernameurl,
    required this.username,
    required this.imageurl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 20,
                backgroundImage: CachedNetworkImageProvider(usernameurl),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              username,
              style: GoogleFonts.roboto(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            GestureDetector(
              child: const Icon(Icons.more_vert),
            ),
            const SizedBox(width: 10),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 400,
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl: imageurl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Center(
              child: Text('Failed to load image'),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  FaIcon(FontAwesomeIcons.heart),
                  SizedBox(width: 15),
                  FaIcon(FontAwesomeIcons.comment),
                  SizedBox(width: 10),
                  Icon(Icons.share),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                // Add your onTap functionality here
              },
              child: const Icon(Icons.bookmark_outline, size: 27),
            ),
            const SizedBox(width: 10),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
