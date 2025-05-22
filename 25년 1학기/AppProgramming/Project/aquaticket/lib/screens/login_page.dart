import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/services/auth_service.dart';
import 'package:uuid/uuid.dart';
import '/screens/home_page.dart';
import 'sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  Future<void> signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('이메일과 비밀번호를 모두 입력해주세요')),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('로그인 성공')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      print('🔥 FirebaseAuthException code: ${e.code}');

      String message = '로그인 실패';

      if (e.code == 'user-not-found') {
        message = '등록되지 않은 이메일입니다';
      } else if (e.code == 'wrong-password') {
        message = '비밀번호가 올바르지 않습니다';
      } else if (e.code == 'invalid-email') {
        message = '이메일 형식이 올바르지 않습니다';
      } else if (e.code == 'invalid-credential') {
        message = '이메일 또는 비밀번호가 올바르지 않습니다';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('알 수 없는 오류가 발생했습니다')),
      );
    }
  }

  // ✅ UUID 생성 테스트 함수
  void generateUUID() {
    final uuid = Uuid();
    final generated = uuid.v4();

    print("생성된 UUID: $generated");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("UUID: $generated")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: '이메일'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: '비밀번호'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: signIn, child: const Text('로그인')),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              },
              child: const Text('회원가입하기'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: generateUUID,
              child: const Text("🧪 UUID 테스트"),
            ),
          ],
        ),
      ),
    );
  }
}
