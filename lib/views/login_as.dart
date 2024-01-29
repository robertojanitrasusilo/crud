import 'package:flutter/material.dart';

class LoginAs extends StatelessWidget {
  const LoginAs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(onPressed: () {}, child: Text("Login as Admin")),
          SizedBox(height: 20),
          ElevatedButton(onPressed: () {}, child: Text("Login as User")),
        ]),
      ),
    );
  }
}
