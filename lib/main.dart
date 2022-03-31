import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("MyHomePageをレンダリング");
    return ChangeNotifierProvider(
      //これが必要
      create:(context) => MyHomePageState(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("flutter lab"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              WidgetA(),
              WidgetB(),
              WidgetC(),
              WidgetD(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePageState extends ChangeNotifier{
  int counter =0;

  void increment(){
    counter ++;
    //これを必ず入れる
    notifyListeners();
  }

  void decrement(){
    counter --;
    notifyListeners();
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
  const WidgetB({Key? key}) : super(key: key);
  //stateを上から受け取る
  @override
  Widget build(BuildContext context) {
    print("widget");
    // watchでstateの情報をアクセスできる

    // watchにすると、常に再描画される。
    // final int counter =context.watch<MyHomePageState>().counter;

    //カウンターの状態変わっていない時はselectを使用する。
    final int counter =context.select<MyHomePageState,int>((state) => state.counter);

    return Text(
      '$counter',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}

class WidgetC extends StatelessWidget {
  const WidgetC({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("WidgetCをビルド");

    //readはstateの再描画をしない。
    //buttonの状態が変わらない。
    final Function increment =context.read<MyHomePageState>().increment;
    return ElevatedButton(
        onPressed: () {
          increment();
        },
        child: const Text("カウント"));
  }
}


class WidgetD extends StatelessWidget {
  const WidgetD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("WidgetDをビルド");
    final Function decrement =context.read<MyHomePageState>().decrement;
    return ElevatedButton(
        onPressed: () {
          decrement();
        },
        child: const Text("カウント"));
  }
}