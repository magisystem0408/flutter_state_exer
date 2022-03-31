import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//statefulWidgetを作ったらこれを作成しないといけない。
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("MyHomePageをレンダリング");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //constで再描画しなくて良いと明示的になる。
            const WidgetA(),
            WidgetB(_counter),
            WidgetC(_incrementCounter),
          ],
        ),
      ),
    );
  }
}


class WidgetA extends StatelessWidget {
  const WidgetA({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("WidgetAをビルド");
    return const Text(
      "you have pushed the button this many times",
    );
  }
}

class WidgetB extends StatelessWidget {
  const WidgetB(this.counter, {Key? key}) : super(key: key);
  //stateを上から受け取る
  final int counter;
  @override
  Widget build(BuildContext context) {
    print("WidgetBをビルド");
    return Text(
      '$counter',
      style: Theme
          .of(context)
          .textTheme
          .headline4,
    );
  }
}

class WidgetC extends StatelessWidget {
  const WidgetC(this.increment, {Key? key}) : super(key: key);
  final Function increment;
  @override
  Widget build(BuildContext context) {
    print("WidgetCをビルド");
    return ElevatedButton(onPressed: () {
      increment();
    }, child: const Text("カウント"));
  }
}
