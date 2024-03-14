import 'dart:convert';

import 'package:educare/DashBord.dart';
import 'package:educare/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController sid = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> login() async {
    var uri = "http://10.0.2.2/studentscool/login.php";
    final response = await http.post(Uri.parse(uri), body: {
      'sid': sid.text,
      'password': password.text,
    });

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result == 'Success') {
        print("Login Successfull!");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DashBoard(),
          ),
        );
      } else {
        print(result);
      }
    } else {
      print('Error:${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(),
              _inputField(context),
              _forgotPassword(),
              _signup(context),
            ],
          ),
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  Widget _header() {
    return const Column(
      children: [
        Text(
          "Welcome ",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("EDUCare App"),
      ],
    );
  }

  Widget _inputField(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      TextField(
        controller: sid,
        decoration: InputDecoration(
          hintText: "Enter SID",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
          filled: true,
          prefixIcon: const Icon(
            Icons.person,
          ),
        ),
      ),
      const SizedBox(height: 10),
      TextField(
        controller: password,
        decoration: InputDecoration(
          hintText: "Enter password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
          filled: true,
          prefixIcon: const Icon(Icons.lock),
        ),
        obscureText: true,
      ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          login();
        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text(
          "Login",
          style: TextStyle(fontSize: 20),
        ),
      ),
    ]);
  }

  Widget _forgotPassword() {
    return TextButton(
      onPressed: () {},
      child: const Text("Forgot password"),
    );
  }

  Widget _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Have't an account?"),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Register(),
              ),
            );
          },
          child: const Text("Sign Up"),
        ),
      ],
    );
  }
}
