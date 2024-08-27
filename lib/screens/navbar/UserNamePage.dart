import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:instagaramclone/screens/PostsFullScreen.dart';
import 'package:instagaramclone/widgets/profileWidget.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UsernamePage extends StatefulWidget {
  @override
  _UsernamePageState createState() => _UsernamePageState();
}

class _UsernamePageState extends State<UsernamePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  String _username = "User123";

  late TabController _tabBarController;

  final List<List<String>> images = [
    ["https://i.redd.it/dukx8ilupck91.jpg"],
  ];

  @override
  void initState() {
    super.initState();
    _usernameController.text = _username;
    _tabBarController = TabController(length: 2, vsync: this);
    _loadImages();
  }

  @override
  void dispose() {
    _tabBarController.dispose();
    _usernameController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  Future<void> _loadImages() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('images');
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      setState(() {
        // images = jsonList.map((item) => List<String>.from(item)).toList();
      });
    }
  }

  Future<void> _saveImages() async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = json.encode(images);
    await prefs.setString('images', jsonString);
  }

  void _addImage(String url) {
    setState(() {
      images.add([url]);
      _saveImages();
    });
  }

  void _showAddImageBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _linkController,
                  decoration: const InputDecoration(
                    hintText: 'Enter image URL',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_linkController.text.isNotEmpty) {
                      _addImage(_linkController.text);
                      _linkController.clear();
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Add Image'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _statsPosition(String count, String label) {
    if (count.isEmpty) {
      count = "0";
    }
    return Column(
      children: [
        Text(
          count,
          style: GoogleFonts.roboto(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: GoogleFonts.roboto(
            fontSize: 16.0,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ],
    );
  }

  Widget _addPostsButton() {
    return GestureDetector(
      onTap: _showAddImageBottomSheet,
      child: Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(9),
          shape: BoxShape.rectangle,
          border:
              Border.all(color: Theme.of(context).iconTheme.color!, width: 2),
        ),
        child: Center(
          child: Icon(
            Icons.add,
            color: Theme.of(context).iconTheme.color,
            size: 22,
          ),
        ),
      ),
    );
  }

  Widget _buildPostGrid() {
    if (images.isEmpty) {
      return const Center(
        child: Text("No Images Found"),
      );
    } else {
      return GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          if (images[index].isEmpty) return Container(); // Handle empty images
          String tag = 'image$index';
          Widget imageWidget = CachedNetworkImage(
            imageUrl: images[index][0],
            fit: BoxFit.cover,
          );
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostScreen(
                    imageUrls: images[index],
                    tag: tag,
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Hero(tag: tag, child: imageWidget),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double dimension = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        //   elevation: 0,
        //   title: Row(
        //     children: [
        //       Icon(
        //         Icons.lock_outline,
        //         color: Theme.of(context).iconTheme.color,
        //         size: 20,
        //       ),
        //       const SizedBox(width: 10),
        //       Text(
        //         _username,
        //         style: GoogleFonts.roboto(
        //           fontSize: 22.0,
        //           fontWeight: FontWeight.w600,
        //           color: Theme.of(context).appBarTheme.titleTextStyle?.color,
        //         ),
        //       ),
        //       const SizedBox(width: 4),
        //       GestureDetector(
        //         child: Icon(
        //           Icons.keyboard_arrow_down,
        //           color: Theme.of(context).iconTheme.color,
        //         ),
        //       )
        //     ],
        //   ),
        //   actions: [
        //     _addPostsButton(),
        //     const SizedBox(width: 20),
        //     GestureDetector(
        //       onTap: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => LoginScreen()),
        //         );
        //       },
        //       child: Icon(Icons.menu, color: Theme.of(context).iconTheme.color),
        //     ),
        //     const SizedBox(width: 10),
        //   ],
        // ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock_outline,
                        color: Theme.of(context).iconTheme.color,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _username,
                        style: GoogleFonts.roboto(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                      const Spacer(),
                      _addPostsButton(),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(Icons.menu,
                            color: Theme.of(context).iconTheme.color),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),

                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Profile Picture
                      const AvatarWidgetCustom(),

                      // Stats (Posts, Followers, Following)
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _statsPosition(images.length.toString(), "Posts"),
                            _statsPosition("0", "Followers"),
                            _statsPosition("0", "Following"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pratap",
                        style: GoogleFonts.roboto(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Decide your habits and your habits will decide your future",
                        style: GoogleFonts.aBeeZee(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: TabBar(
                    controller: _tabBarController,
                    indicatorColor: Colors.blue,
                    indicator: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    tabs: [
                      Tab(
                          icon: Icon(Icons.grid_on,
                              color: Theme.of(context).iconTheme.color)),
                      Tab(
                          icon: Icon(Icons.person_pin,
                              color: Theme.of(context).iconTheme.color)),
                    ],
                  ),
                ),
                // To allow the grid to take up the remaining space
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      300, // Adjust this value
                  child: TabBarView(
                    controller: _tabBarController,
                    children: [
                      _buildPostGrid(),
                      const Center(child: Text('Profile Tab Content')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
