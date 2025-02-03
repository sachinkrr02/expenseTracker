import 'dart:async';
import 'package:expense_tracker/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color.fromRGBO(67, 34, 75, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo with Hero animation for a smooth transition effect
            Hero(
              tag: 'app-logo',
              child: Image.asset(
                "assets/logobgr.png",
                width: 180,
              ),
            ),
            const SizedBox(height: 20),

            // App name with custom styling
            const Text(
              "Expensi",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 10),

            // Tagline
            const Text(
              "Track your expenses, effortlessly",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 40),

            // Lottie animation for dynamic visual effect
            Lottie.network(
              "https://lottie.host/76bbb7c4-07e5-4c52-89a6-c9523fc5b5e5/A78TDs9WH9.json",
              height: 120,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 30),

            // Progress indicator
            // const CircularProgressIndicator(
            //   valueColor: AlwaysStoppedAnimation<Color>(Colors.tealAccent),
            //   strokeWidth: 3,
            // ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF162447),
        title: const Text(
          "Expensi",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "Welcome to Expensi!",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
