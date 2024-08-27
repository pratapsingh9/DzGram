import 'package:flutter/material.dart';
import 'package:instagaramclone/screens/UserMangeScreens/UserSignInScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          // Light theme (Default)
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 1, // Adds a subtle shadow like Instagram
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
          ),
          iconTheme: const IconThemeData(
            color: Colors.black, // Icon color for the light theme
          ),
        ),
        darkTheme: ThemeData(
          primaryColor: Colors.black,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              color: Colors.white,
            ),
            bodyMedium: TextStyle(
              color: Colors.white, // Add other text styles as needed
            ),
            // Add more text styles if needed
          ),
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            elevation: 1,
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
          ),
          iconTheme: const IconThemeData(
            color: Colors.white, // Icon color for the dark theme
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const UserSignInScreen());
  }
}
