import 'package:flutter/material.dart';

void main() => runApp(const DashBoard());

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome you!"),
      ),
    );
  }
}
