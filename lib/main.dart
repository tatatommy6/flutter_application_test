import 'package:flutter/material.dart';
import 'package:flutter_application_test/new_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),useMaterial3: true),
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

  void _gotoNewScreen() {
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

  void _reset() {
    setState(() {
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
            const CounterDescription(),
            CounterValue(value: _counter),

            const SizedBox(height: 20),

            CounterActions(onIncrement: _incrementCounter, onReset: _reset, onGoNext: _gotoNewScreen),
          ],
        ),
      ),
    );  
  }
}
class CounterDescription extends StatelessWidget{
  const CounterDescription({super.key});

  @override
  Widget build(BuildContext context){
    return const Text('you have pushed the button this many times', textAlign: TextAlign.center);
  }
}

class CounterValue extends StatelessWidget{
  const CounterValue({super.key, required this.value});

  final int value;

  @override
  Widget build(BuildContext context){
    return Text('$value', style: Theme.of(context).textTheme.headlineMedium);
  }
}

class CounterActions extends StatelessWidget {
  const CounterActions({
    super.key,
    required this.onIncrement,
    required this.onReset,
    required this.onGoNext
    });

  final VoidCallback onIncrement;
  final VoidCallback onReset;
  final VoidCallback onGoNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(onPressed: onIncrement, heroTag: 'btn1', tooltip: 'increment', child: const Icon(Icons.add)),
        const SizedBox(width: 15,),
        FloatingActionButton(onPressed: onReset, heroTag: 'btn2', tooltip: 'reset numbers', child: const Icon(Icons.delete)),
        const SizedBox(width: 15,),
        FloatingActionButton(onPressed: onGoNext, heroTag: 'btn3', tooltip: 'go to next page', child: const Icon(Icons.navigate_next)),
      ],
    );
  }
}
