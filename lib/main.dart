import 'package:flutter/material.dart';
import 'package:flutter_application_test/new_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  bool _isDarkMode = false; 

  void _toogleTheme(){
    setState((){
      _isDarkMode = !_isDarkMode;
    });
  }
    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),useMaterial3: true),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark: ThemeMode.light,
      home: MyHomePage(title: 'Flutter Demo Home Page', onToggleTheme: _toogleTheme, isDarkMode: _isDarkMode,),
      debugShowCheckedModeBanner: false,
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.onToggleTheme, required this.isDarkMode});

  final VoidCallback onToggleTheme;
  final bool isDarkMode;
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
    _saveCounter(); //값 변경 후 저장
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
    _saveCounter(); // 리셋 후 저장
  }

  Future<void> _saveCounter() async{ //future: 미래에 완료되는 작업을 나타내는 타입. 비동기 작업을 표햔하는 dart의 기본 타입
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _counter);
  }

  //future<void>의 의미는 "이 작업은 비동기로 진행되며, 완료되면 아무 값도 돌려주지 않는다."
  Future<void> _loadCounter() async{
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getInt('counter') ?? 0; // 값이 없으면 0
    setState(() {
      _counter = saved;
    });
  }

  @override
  void initState(){
    super.initState();
    _loadCounter(); //앱 시작될 때 저장된 값 불러오기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: widget.onToggleTheme, icon: Icon(widget.isDarkMode ? Icons.dark_mode : Icons.light_mode)),
        ],
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
