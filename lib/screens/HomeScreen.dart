import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:instagaramclone/models/PostModel.dart';
import 'package:instagaramclone/screens/navbar/UserNamePage.dart';
import 'package:instagaramclone/widgets/PostsScreens.dart';

import 'package:shimmer/shimmer.dart';


final List<PostModel> postsData = [
  PostModel(
      Imageurl:
          "https://ichef.bbci.co.uk/news/976/cpsprodpb/147C0/production/_132740938_indeximage.jpg",
      username: "Jhonny dead",
      usernameurl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4wd5Y_quLqQ4f6lLUlyhHR188NAaDLq8PsA&s"),
  PostModel(
      Imageurl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEO4xAVGmtL4G0PTO91T5C9gYciH_lkm513w&s",
      username: 'Pratap Singh',
      usernameurl:
          "https://images.pexels.com/photos/1716861/pexels-photo-1716861.jpeg"),
  PostModel(
      Imageurl:
          "https://staticg.sportskeeda.com/editor/2023/08/3626c-16921875120044-1920.jpg?w=640",
      username: "ps9",
      usernameurl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLbcn9WCT3O7yEHyqvnkfOFx8y2bLsf4OZlw&s"),
  PostModel(
      Imageurl:
          "https://yt3.googleusercontent.com/8eGqQZxpSdVKFel6OBsW5orqJ1mC_2h_sPKbR4al6eqOM2rV-2ahi6FhEWT-L9PmWjgfhsJhSeY=s900-c-k-c0x00ffffff-no-rj",
      username: "Shibu",
      usernameurl:
          "https://i.pinimg.com/736x/bf/95/34/bf953419d76bf747cba69b55e6e03957.jpg")
];

class Homescreen extends StatefulWidget {
  Homescreen({
    super.key,
  });

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeScreen(),
          _buildSearchScreen(),
          _buildAddPostScreen(),
          UsernamePage()
        ],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 44,
        decoration: BoxDecoration(
            // Remove or set the border to null
            // border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home,
                  size: 28,
                  color: _selectedIndex == 0
                      ? Theme.of(context)
                          .bottomNavigationBarTheme
                          .selectedItemColor
                      : Theme.of(context)
                          .bottomNavigationBarTheme
                          .unselectedItemColor),
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: Icon(Icons.search,
                  size: 28,
                  color: _selectedIndex == 1
                      ? Theme.of(context)
                          .bottomNavigationBarTheme
                          .selectedItemColor
                      : Theme.of(context)
                          .bottomNavigationBarTheme
                          .unselectedItemColor),
              onPressed: () => _onItemTapped(1),
            ),
            IconButton(
              icon: Icon(Icons.add_box_outlined,
                  size: 28,
                  color: _selectedIndex == 2
                      ? Theme.of(context)
                          .bottomNavigationBarTheme
                          .selectedItemColor
                      : Theme.of(context)
                          .bottomNavigationBarTheme
                          .unselectedItemColor),
              onPressed: () => _onItemTapped(2),
            ),
            GestureDetector(
              onTap: () => _onItemTapped(3),
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/profile_picture.jpg'),
                  ),
                  border: Border.all(
                    color: _selectedIndex == 3
                        ? Theme.of(context)
                            .bottomNavigationBarTheme
                            .selectedItemColor!
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeScreen() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Image.asset(
          'assets/instagram.jpg',
          color: Theme.of(context).appBarTheme.iconTheme?.color,
          height: 85,
          width: 150,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FaIcon(
                FontAwesomeIcons.heart,
                color: Theme.of(context).appBarTheme.iconTheme?.color,
              ),
              const SizedBox(width: 10),
              FaIcon(
                FontAwesomeIcons.facebookMessenger,
                color: Theme.of(context).appBarTheme.iconTheme?.color,
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: postsData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: index == 0 ? Colors.red : Colors.grey,
                                  width: 3,
                                ),
                              ),
                            ),
                            CachedNetworkImage(
                              imageUrl: postsData[index].Imageurl,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            if (index == 0)
                              Positioned(
                                right: 1,
                                bottom: 6,
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          index == 0 ? "Pratap" : "User $index",
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Posts(
                  usernameurl: postsData[index].usernameurl,
                  username: postsData[index].username,
                  imageurl: postsData[index].Imageurl,
                );
              },
              childCount: postsData.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchScreen() {
    return const Center(
      child: Text('Search Screen', style: TextStyle(fontSize: 24)),
    );
  }

  Widget _buildAddPostScreen() {
    return const Center(
      child: Text('Add Post Screen', style: TextStyle(fontSize: 24)),
    );
  }
}
