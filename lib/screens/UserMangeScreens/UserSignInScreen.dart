import 'package:flutter/material.dart';

import 'package:instagaramclone/screens/UserMangeScreens/UserSingUp.dart';

class UserSignInScreen extends StatefulWidget {
  const UserSignInScreen({super.key});

  @override
  State<UserSignInScreen> createState() => _UserSignInScreenState();
}

class _UserSignInScreenState extends State<UserSignInScreen> {
  @override
  Widget build(BuildContext context) {
    // Determine if the current theme is dark
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 60),
              // Update image asset depending on the theme
              Image.asset(
                isDark ? 'assets/dark.jpg' : 'assets/instagram.jpg',
                height: 200,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Your Email",
                  hintStyle: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color ??
                          Colors.grey[600]),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[800]
                      : Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 14.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Your Password",
                  hintStyle: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color ??
                          Colors.grey[600]),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[800]
                      : Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 14.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: .0),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade400,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an Account",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const UserSingUpScreeen()), // Corrected the name
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Text(
                "Forget Password",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
