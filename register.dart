import 'dart:convert';

import 'package:educare/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  TextEditingController sid = TextEditingController();
  TextEditingController uname = TextEditingController();
  TextEditingController pone = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> insertrecord() async {
    if (sid.text != "" ||
        uname.text != "" ||
        pone.text != "" ||
        password.text != "") {
      try {
        String uri = "http://10.0.2.2/studentscool/insert_record.php";
        var res = await http.post(Uri.parse(uri), body: {
          "sid": sid.text,
          "uname": uname.text,
          "pone": pone.text,
          "password": password.text
        });
        var response = jsonDecode(res.body);
        if (response["success"] == "true") {
          //print("Insert Successfull!");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHomePage(),
            ),
          );
        } else {
          print("Some Issue found!");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("please fill all the fileds");

      // Navigator.push
      // (
      // context,
      // MaterialPageRoute(
      // builder: (context) => MyHomePage(),
      // ),
      // );
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
          "Welcome",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your truthful details"),
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
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
          filled: true,
          prefixIcon: const Icon(Icons.person),
        ),
      ),
      const SizedBox(height: 10),
      TextField(
        controller: uname,
        decoration: InputDecoration(
          hintText: "Username",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
          filled: true,
          prefixIcon: const Icon(Icons.person),
        ),
      ),
      const SizedBox(height: 10),
      TextField(
        controller: pone,
        decoration: InputDecoration(
          hintText: "Enter phone NO",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
          filled: true,
          prefixIcon: const Icon(Icons.phone),
        ),
      ),
      const SizedBox(height: 10),
      TextField(
        controller: password,
        decoration: InputDecoration(
          hintText: "Enter password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
          filled: true,
          prefixIcon: const Icon(Icons.lock),
        ),
        obscureText: true,
      ),
      const SizedBox(height: 10),
      ElevatedButton(
        onPressed: () {
          insertrecord();
        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text(
          "Register",
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
        const Text("Already have an account?"),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyHomePage(),
              ),
            );
          },
          child: const Text("Sign in"),
        ),
      ],
    );
  }
}
