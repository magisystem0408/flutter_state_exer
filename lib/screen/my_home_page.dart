import 'package:flutter/material.dart';
import 'package:flutter_state_exer/state/my_home_state.dart';
import 'package:flutter_state_exer/view_model/my_home_view_model.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/src/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("MyHomePageをレンダリング");
    return StateNotifierProvider<MyHomePageStateNotifier,MyHomePageState>(
      //これが必要
      create:(context) => MyHomePageStateNotifier(),
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
            ],
          ),
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
    final Function increment =context.read<MyHomePageStateNotifier>().increment;
    return ElevatedButton(
        onPressed: () {
          increment();
        },
        child: const Text("カウント"));
  }
}