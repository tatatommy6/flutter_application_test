import 'package:flutter/material.dart';
import 'package:flutter_application_test/new_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.blueAccent),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _gotoNewScreen(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewScreen()),
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _reset(){
    setState((){
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('You have pushed the button this many times'),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                onPressed: _incrementCounter,
                heroTag: 'btn1',
                tooltip: 'increment',
                child: const Icon(Icons.add),
              ),
              const SizedBox(width:15),
              FloatingActionButton(
                onPressed: _gotoNewScreen,
                heroTag: 'btn2',
                tooltip: 'go to a new screen',
                child: const Icon(Icons.navigate_next)
                ),
              const SizedBox(width:15),
              FloatingActionButton(
                onPressed: _reset,
                heroTag: 'btn3',
                tooltip: 'reset counter',
                child: const Icon(Icons.delete)
              )
              ],
            ),
          ],
        ),
      ),
    );
  }
}