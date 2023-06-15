import 'package:flutter/material.dart';

class FailureScreen extends StatelessWidget {
  final String message;
  const FailureScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FailureBody(message: message),
    );
  }
}

class FailureBody extends StatelessWidget {
  final String message;
  const FailureBody({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
