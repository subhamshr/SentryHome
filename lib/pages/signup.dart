import "package:flutter/material.dart";
import "package:sentryhome/services/firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

import "../helper/helper_functions.dart";

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // firestore
  final FirestoreService firestoreService = FirestoreService();

  // text controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPWController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void signupUser(BuildContext context) async {
    // show  loading circle
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    // make sure the passwords match
    if (passwordController.text != confirmPWController.text) {
      // pop the loading circle
      Navigator.pop(context);
      // show error msg
      displayMessageToUser("Passwords dont match", context);
    }
    // creating the user
    else {
      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        // pop loading circle
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // pop loading circle
        if (context.mounted) Navigator.pop(context);
        // display error msg
        if (context.mounted) displayMessageToUser(e.code, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: Scaffold(
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        height: MediaQuery.of(context).size.height - 50,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Column(
              children: <Widget>[
                SizedBox(height: 30.0),
                Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Sign Up as a New User",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Column(
              children: <Widget>[
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      hintText: "Username",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: const Color.fromRGBO(160, 160, 160, 0.7),
                      filled: true,
                      prefixIcon: const Icon(Icons.person)),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: const Color.fromRGBO(160, 160, 160, 0.7),
                      filled: true,
                      prefixIcon: const Icon(Icons.email)),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: const Color.fromRGBO(160, 160, 160, 0.7),
                    filled: true,
                    prefixIcon: const Icon(Icons.password),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: confirmPWController,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: const Color.fromRGBO(160, 160, 160, 0.7),
                    filled: true,
                    prefixIcon: const Icon(Icons.password),
                  ),
                  obscureText: true,
                ),
              ],
            ),
            Container(
                padding: const EdgeInsets.only(top: 3, left: 3),
                child: ElevatedButton(
                  onPressed: () => signupUser(context),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color.fromRGBO(79, 79, 79, 0.7),
                  ),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                )),
            const Center(child: Text("Or")),
            Container(
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.black),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 30.0,
                      width: 30.0,
                      decoration: const BoxDecoration(
                        // image: DecorationImage(
                        //     image: AssetImage(
                        //         'assets/images/login_signup/google.png'),
                        //     fit: BoxFit.cover),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 18),
                    const Text(
                      "Sign In with Google",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Already have an account?"),
                InkWell(
                    onTap: () {
                      // Navigate to the LoginPage tab
                      DefaultTabController.of(context)
                          .animateTo(0); // Navigate to the first tab (index 0)
                    },
                    child: const Text(
                      " Sign In",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ))
              ],
            )
          ],
        ),
      ),
      // ),
      // ),
    );
  }
}
