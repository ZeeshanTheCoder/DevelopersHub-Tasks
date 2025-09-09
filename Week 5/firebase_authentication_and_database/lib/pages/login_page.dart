import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'register_page.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.orange.shade900, Colors.yellow.shade400],
                begin: Alignment.topCenter)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Login',
                      style: TextStyle(color: Colors.white, fontSize: 40)),
                  Text('Welcome back!',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ]),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(60))),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(children: [
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
                                offset: const Offset(0, 10))
                          ],
                        ),
                        child: Column(children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none),
                              validator: _validateEmail,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none),
                              validator: _validatePassword,
                            ),
                          ),
                        ]),
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          try {
                            final userCredential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );

                            final userDoc = await FirebaseFirestore.instance
                                .collection('users')
                                .doc(userCredential.user!.uid)
                                .get();

                            final userName = (userDoc.exists &&
                                    userDoc.data()!['name'] != null)
                                ? userDoc.data()!['name']
                                : emailController.text.trim();

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => HomePage(name: userName)),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Login failed: ${e.toString()}')));
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(200, 50),
                        backgroundColor: Colors.orange.shade900,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      child: const Text('Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 30),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text("Don't have an account?",
                          style: TextStyle(color: Colors.grey)),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const RegisterPage()));
                        },
                        child: Text("Register",
                            style: TextStyle(color: Colors.orange.shade900)),
                      ),
                    ]),
                    const SizedBox(height: 123),
                  ]),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
