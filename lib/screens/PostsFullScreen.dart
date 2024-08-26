import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagaramclone/screens/commentSection.dart';

import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class PostScreen extends StatefulWidget {
  final List<String> imageUrls; // List of image URLs
  final String tag;

  const PostScreen({super.key, required this.imageUrls, required this.tag});

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  void _navigateToComments() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CommentsScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.toInt() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back, color: Theme.of(context).textTheme.bodyLarge?.color),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Post',
          style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 20,
                  backgroundImage: CachedNetworkImageProvider(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEW_Jgyi6ooEMPjdwuAHg4E5CpLBqlL6ul-A&s'),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "Pratap Singh",
                style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyLarge?.color),
              ),
              const Spacer(),
              GestureDetector(
                child: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).iconTheme.color,
                ),
                onTap: () {
                  // Add your logic here
                },
              ),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 15),
          Expanded(
            child: widget.imageUrls.length == 1
                ? CachedNetworkImage(
                    imageUrl: widget.imageUrls[0],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  )
                : Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: widget.imageUrls.length,
                        itemBuilder: (context, index) {
                          return CachedNetworkImage(
                            imageUrl: widget.imageUrls[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          );
                        },
                      ),
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: PageViewDotIndicator(
                            count: widget.imageUrls.length,
                            currentItem: _currentPage,
                            selectedColor: Colors.blue,
                            size: Size(5, 8),
                            unselectedColor: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                 FaIcon(
                  FontAwesomeIcons.heart,
                  color: Theme.of(context).iconTheme.color,
                ),
                const SizedBox(width: 21),
                GestureDetector(
                  onTap: _navigateToComments,
                  child:  FaIcon(
                    FontAwesomeIcons.comment,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                const Spacer(),
                 Icon(
                  Icons.bookmark_outline,
                  color: Theme.of(context).iconTheme.color,
                  size: 28,
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
