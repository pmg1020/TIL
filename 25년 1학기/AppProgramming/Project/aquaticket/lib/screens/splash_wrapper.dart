import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'home_page.dart';

class SplashWrapper extends StatelessWidget {
  const SplashWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    // 로그인된 상태라면 HomePage로 이동, 아니면 LoginPage로 이동
    if (user != null) {
      return const HomePage();
    } else {
      return const LoginPage();
    }
  }
}
