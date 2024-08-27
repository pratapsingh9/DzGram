import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class PostScreen extends StatefulWidget {
  final List<String> imageUrls;
  final String tag;

  const PostScreen({Key? key, required this.imageUrls, required this.tag})
      : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen>
    with SingleTickerProviderStateMixin {
  PageController _pageController = PageController();
  int _currentPage = 0;
  bool fav = false;
  bool isLiked = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.toInt() ?? 0;
      });
    });

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _navigateToComments() {
    // Implement navigation to comments screen
  }

  void _handleDoubleTap() {
    setState(() {
      isLiked = true;
    });
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Theme.of(context).textTheme.bodyLarge?.color),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Post',
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          _buildUserInfo(),
          SizedBox(height: 15),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                _buildImageContent(),
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Icon(
                    Icons.favorite,
                    color: Colors.grey.shade200,
                    size: 190,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          _buildActionButtons(),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  Widget _buildUserInfo() {
    return Row(
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
        SizedBox(width: 10),
        Text(
          "Pratap Singh",
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        Spacer(),
        IconButton(
          icon: Icon(Icons.more_vert, color: Theme.of(context).iconTheme.color),
          onPressed: () {/* Add your logic here */},
        ),
      ],
    );
  }

  Widget _buildImageContent() {
    return GestureDetector(
      onDoubleTap: _handleDoubleTap,
      child: widget.imageUrls.length == 1
          ? Hero(
              tag: widget.tag,
              child: CachedNetworkImage(
                imageUrl: widget.imageUrls[0],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
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
                      unselectedColor: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isLiked = !isLiked;
              });
            },
            child: FaIcon(
              isLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
              color: isLiked ? Colors.red : Theme.of(context).iconTheme.color,
            ),
          ),
          const SizedBox(width: 21),
          GestureDetector(
            onTap: _navigateToComments,
            child: FaIcon(
              FontAwesomeIcons.comment,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              setState(() {
                fav = !fav;
              });
            },
            child: Icon(
              fav ? Icons.bookmark : Icons.bookmark_outline,
              color: Theme.of(context).iconTheme.color,
              size: 28,
            ),
          )
        ],
      ),
    );
  }
}
