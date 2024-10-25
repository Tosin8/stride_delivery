
// CONNECT TO FIREBASE. 
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/forms/login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            // Use constraints to determine screen size
            bool isTablet = constraints.maxWidth > 600;
            return FadeIn(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOutQuad,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    // Replace with Firebase image loading
                    image: NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/stride-67509.appspot.com/o/splash.jpg?alt=media&token=3dcf35df-8097-4033-84c5-ab2142382316'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Dynamic Text Size
                      FadeIn(
                        delay: const Duration(milliseconds: 1000),
                        duration: const Duration(milliseconds: 1000),
                        child: Text(
                          'Stride',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isTablet ? 60 : 40, // Responsive font size
                            fontFamily: 'Maturascript',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        height: 3,
                        thickness: 2,
                        indent: 100,
                        endIndent: 100,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 20),
                      FadeInUp(
                        curve: Curves.easeInBack,
                        delay: const Duration(milliseconds: 1500),
                        duration: const Duration(milliseconds: 1000),
                        child: Text(
                          'Thousands of Shoe Styles\nfrom Top Brands',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isTablet ? 30 : 20, // Responsive font size
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 40),
                      const SplashButton(), // Responsive button
                      SizedBox(height: isTablet ? 80 : 60),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SplashButton extends StatelessWidget {
  const SplashButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Check if the screen is a tablet
    bool isTablet = MediaQuery.of(context).size.width > 600;

    return FadeInUp(
      curve: Curves.easeInBack,
      delay: const Duration(milliseconds: 2000),
      duration: const Duration(milliseconds: 1000),
      child: GestureDetector(
        onTap: () {
          Get.to(() => const LoginScreen());
        },
        child: Container(
          height: isTablet ? 70 : 50, // Responsive height
          width: isTablet ? 250 : 200, // Responsive width
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Align(
            child: Text(
              'Start Shopping',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
