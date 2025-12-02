import 'package:flutter/material.dart';

class NewScreen extends StatelessWidget {
  const NewScreen({super.key});
  @override

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("new screen")),
        body: Center(
          child : Text("this is a new screen!"),
        ),
    );
  }
}