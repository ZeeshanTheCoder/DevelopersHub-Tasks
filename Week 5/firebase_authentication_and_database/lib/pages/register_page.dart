import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    String? _validateEmail(String? value) {
      if (value == null || value.isEmpty) return 'Please enter an email';
      final regex = RegExp(r'^[\w.%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
      if (!regex.hasMatch(value)) return 'Enter a valid email address';
      return null;
    }

    String? _validatePassword(String? value) =>
        (value == null || value.isEmpty) ? 'Please enter a password' : null;

    String? _validateName(String? value) =>
        (value == null || value.isEmpty) ? 'Please enter your name' : null;

    Future<void> _registerUser(BuildContext context) async {
      if (!_formKey.currentState!.validate()) return;

      final String name = usernameController.text.trim();
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      try {
        // 1. Create user with Firebase Auth
        final userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        final uid = userCredential.user!.uid;

        // 2. Save user details to Firestore
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'name': name,
          'email': email,
        });

        // 3. Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful! Please log in.'),
          ),
        );

        // 4. Redirect to Login Page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      } catch (e) {
        // Handle errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${e.toString()}')),
        );
      }
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade900, Colors.yellow.shade400],
            begin: Alignment.topCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Register',
                      style: TextStyle(color: Colors.white, fontSize: 40)),
                  Text('Create new account!',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(60),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 60),
                        Form(
                          key: _formKey,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromRGBO(225, 95, 27, 0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                _buildInputField(
                                  controller: usernameController,
                                  hintText: 'Name',
                                  validator: _validateName,
                                ),
                                _buildInputField(
                                  controller: emailController,
                                  hintText: 'Email',
                                  keyboardType: TextInputType.emailAddress,
                                  validator: _validateEmail,
                                ),
                                _buildInputField(
                                  controller: passwordController,
                                  hintText: 'Password',
                                  obscureText: true,
                                  validator: _validatePassword,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () => _registerUser(context),
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(200, 50),
                            backgroundColor: Colors.orange.shade900,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoginPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(color: Colors.orange.shade900),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 54),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
        validator: validator,
      ),
    );
  }
}
