import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/widgets.dart';
import 'package:sentryhome/auth/auth.dart';
import 'firebase_options.dart';
// import 'pages/login.dart';
// import 'pages/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'SentryHome',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            bottom: const TabBar(
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              tabs: [
                Tab(text: 'Login'),
                Tab(text: 'Signup'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              // LoginPage(),
              // SignupPage(),
              AuthPage()
            ],
          ),
        ),
      ),
    );
  }
}
