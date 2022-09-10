import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        title: const Text(
          "INTERNET CONNECTIVITY",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 15,
        centerTitle: true,
      ),
      body: Center(
          child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              blurRadius: 25,
              spreadRadius: 5.0,
              color: Colors.deepPurple,
            ),
          ],
        ),
        child: ElevatedButton(
          child: const Text("Move Backward"),
          onPressed: () => Navigator.pop(context),
        ),
      )),
    );
  }
}
