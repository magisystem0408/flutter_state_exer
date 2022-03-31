import 'dart:async';

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
  State<MyHomePage> createState() => MyHomePageState();
}

//statefulWidgetを作ったらこれを作成しないといけない。
class MyHomePageState extends State<MyHomePage> {
  late MyHomePageLogic myHomePageLogic;

  @override
  void initState() {
    super.initState();
    myHomePageLogic =MyHomePageLogic();
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
            const WidgetA(),
            WidgetB(myHomePageLogic),
            WidgetC(myHomePageLogic),
          ],
        ),
      ),
    );
  }
}

//redux
class MyHomePageLogic {
  MyHomePageLogic() {
    _counterController.sink.add(_counter);
  }

  final StreamController<int> _counterController = StreamController();
  int _counter = 0;
  Stream<int> get count => _counterController.stream;

  void increments() {
    _counter++;
    _counterController.sink.add(_counter);
  }

  void dispose(){
    _counterController.close();
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
  const WidgetB(this.myHomePageLogic,{Key? key}) : super(key: key);

  final MyHomePageLogic myHomePageLogic;

  //stateを上から受け取る
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: myHomePageLogic.count,
      builder: (context, snapshot) {
        print("WidgetBをビルド");
        return Text(
          '${snapshot.data}',
          style: Theme.of(context).textTheme.headline4,
        );
      }
    );
  }
}

class WidgetC extends StatelessWidget {
  const WidgetC(this.myHomePageLogic,{Key? key}) : super(key: key);
  final MyHomePageLogic myHomePageLogic;

  @override
  Widget build(BuildContext context) {
    print("WidgetCをビルド");
    return ElevatedButton(
        onPressed: () {
          myHomePageLogic.increments();
        },
        child: const Text("カウント"));
  }
}
