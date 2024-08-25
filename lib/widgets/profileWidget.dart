import 'package:flutter/material.dart';
class AvatarWidgetCustom extends StatelessWidget {
  const AvatarWidgetCustom({super.key});
  final String profile_url = "https://i.pinimg.com/736x/cb/21/2f/cb212f92878b0a5d511ed98f9ddbf1a8.jpg";
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundImage: NetworkImage(profile_url),
        ),
        Positioned(
          bottom: 4,
          right: -1,
          child: Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2
              ),
            ),
            child: const Center(
              child: Icon(Icons.add , color: Colors.white,),
            ),
          ),
        )
      ],
    );
  }
}