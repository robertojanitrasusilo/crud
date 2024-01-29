// ignore_for_file: use_build_context_synchronously

import 'package:crud/function.dart';
import 'package:crud/main.dart';
import 'package:crud/views/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 150),
          Text(isRegister == true ? "Register" : "Login"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextField(
              controller: userEmailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextField(
              controller: userPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (isRegister == true) {
                var register = await userRegister();
                print(register);
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Register"),
                          content: Text(register == "Error"
                              ? "Register Failed"
                              : "Register Success"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  if (register == "Error") {
                                    Navigator.pop(context);
                                  } else {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen(isAdmin: false)));
                                  }
                                },
                                child: const Text("OK"))
                          ],
                        ));
              } else {
                var admin = await userLogin();
                print(admin);
                if (admin == '1') {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(isAdmin: true)));
                } else {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(isAdmin: false)));
                }
              }
            },
            child: Text(isRegister == true ? "Register" : "Login"),
          ),
          const SizedBox(height: 16),
          isAdmin == true
              ? Container()
              : TextButton(
                  onPressed: () {
                    setState(() {
                      isRegister = !isRegister;
                    });
                  },
                  child: Text(isRegister == true
                      ? "Already have an account? Login"
                      : "Don't have an account? Register"),
                ),
          const SizedBox(height: 16),
          TextButton(
              onPressed: () {
                setState(() {
                  isAdmin = !isAdmin;
                });
              },
              child: Text(isAdmin == true ? "login as User" : "login as Admin"))
        ],
      ),
    );
  }
}
