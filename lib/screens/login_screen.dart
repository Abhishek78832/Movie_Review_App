
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/screens/signup_screen.dart';
import 'package:untitled/screens/verify_email_screen.dart';

import 'home_screen.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final String googleImage =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png";

  bool isPasswordVisible = false;

  // Google Sign-In
  // Google Sign-In
  Future<UserCredential?> signInWithGoogle() async {
    // try {
    //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    //   if (googleUser == null) return null;
    //
    //   final GoogleSignInAuthentication googleAuth =
    //   await googleUser.authentication;
    //
    //   final credential = GoogleAuthProvider.credential(
    //     accessToken: googleAuth.accessToken,
    //     idToken: googleAuth.idToken,
    //   );
    //
    //   final userCredential =
    //   await FirebaseAuth.instance.signInWithCredential(credential);
    //
    //   print("Google sign-in success: ${userCredential.user?.displayName}");
    //   return userCredential;
    // } catch (e) {
    //   print("Google Sign-In failed: $e");
    //   return null;
    // }
  }


  // Email/Password Sign-In
  Future<void> signInWithEmail() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found') {
        message = "No user found with this email.";
      } else if (e.code == 'wrong-password') {
        message = "Incorrect password.";
      } else {
        message = "Login failed: ${e.message}";
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              width: double.infinity,
              child: Image.asset("assets/images/auth_images/Rectangle6.png"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, top: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    fontFamily: "Dongle",
                    color: const Color(0xff305973),
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "WELCOME TO THE WORLD OF MOVIES",
                  style: TextStyle(
                      fontFamily: "Dongle", color: Colors.black, fontSize: 30),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Email Field
            _buildLabel("Email"),
            _buildTextField(emailController, "Enter your email"),
            const SizedBox(height: 20),

            // Password Field
            _buildLabel("Password"),
            _buildTextField(passController, "Enter your password",
                isPassword: true),
            const SizedBox(height: 10),

            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 40),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const VerifyMailScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 30,
                      color: const Color(0xff305973),
                      fontFamily: "Dongle",
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Google Sign-In Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: SizedBox(
                height: 60,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final user = await signInWithGoogle();
                    if (user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Google Sign-In failed"),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(googleImage, height: 24, width: 24),
                      const SizedBox(width: 12),
                      const Text("Sign in with Google",
                          style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),

            // Normal Email/Password Login Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: SizedBox(
                height: 60,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff305973),
                  ),
                  onPressed: (){
                    signInWithEmail();
                  },
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(
                      fontFamily: "Dongle",
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Register Redirect
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontFamily: "Dongle")),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignupScreen()),
                      );
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: Color(0xff305973),
                        fontFamily: "Dongle",
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widgets
  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(left: 40.0),
    child: Align(
      alignment: Alignment.topLeft,
      child: Text(
        text,
        style: const TextStyle(
            fontFamily: "Dongle", color: Colors.black, fontSize: 35),
      ),
    ),
  );

  Widget _buildTextField(TextEditingController controller, String hint,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: SizedBox(
        height: 60,
        child: TextField(
          controller: controller,
          obscureText: isPassword ? !isPasswordVisible : false,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xff305973),
              fontFamily: "Dongle",
              fontSize: 30,
            ),
            border:
            const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            enabledBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(isPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
            )
                : null,
          ),
        ),
      ),
    );
  }
}
