import 'package:crud/function.dart';
import 'package:crud/main.dart';
import 'package:crud/views/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isRegister == true ? "Register" : "Login"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 50),
              isRegister == true
                  ? TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Nama',
                        border: OutlineInputBorder(),
                      ),
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter your name';
                      //   }
                      //   return null;
                      // },
                    )
                  : Container(),
              SizedBox(height: 20),
              TextFormField(
                controller: userEmailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: userPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (isRegister == true) {
                      var register = await userRegister(
                          userEmailController.text,
                          userPasswordController.text);
                      print(register);
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                  content: Text(register == "Error"
                                      ? "Error"
                                      : "Success"),
                                  actions: [
                                    TextButton(
                                        onPressed: () => register == "Error"
                                            ? Navigator.pop(context)
                                            : Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomeScreen())),
                                        child: const Text('OK'))
                                  ]));
                    } else {
                      var login = await userLogin();
                      print(login);
                      if (login == "1") {
                        setState(() {
                          isAdmin = true;
                        });
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      } else {
                        setState(() {
                          isAdmin = false;
                        });
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      }
                    }
                  }
                },
                child: Text(isRegister == true ? "Register" : "Login"),
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () => setState(() {
                        isRegister = !isRegister;
                      }),
                  child: Text(isRegister == true
                      ? "Have a account ? sign in"
                      : "Dont have account ? sign up"))
            ],
          ),
        ),
      ),
    );
  }
}
