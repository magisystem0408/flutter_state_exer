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
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void reBuild(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    print("MyHomePageをレンダリング");
    return MyHomePageInheritedWidget(
      data: this,
      counter: counter,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
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

//inheritedによるstate
class MyHomePageInheritedWidget extends InheritedWidget {
  const MyHomePageInheritedWidget({
    Key? key,
    required Widget child,
    required this.data,
    required this.counter,
  }) : super(key: key, child: child);

  final MyHomePageState data;
  final int counter;


  //ここは決まり文句で書く。
  static MyHomePageState of(BuildContext context, {bool listen = true}) {
    if (listen) {
      //再描画する
      return context
          .dependOnInheritedWidgetOfExactType<MyHomePageInheritedWidget>()!
          .data;
    } else {
      //再描画しない
      return (context
              .getElementForInheritedWidgetOfExactType<
                  MyHomePageInheritedWidget>()!
              .widget as MyHomePageInheritedWidget)
          .data;
    }
  }

  // counterが変わったときに使う。
  @override
  bool updateShouldNotify(MyHomePageInheritedWidget oldWidget) {
    //counterが前のと違う時だけリビルド。
    return counter != oldWidget.counter;
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
    final MyHomePageState state = MyHomePageInheritedWidget.of(context);
    print("WidgetBをビルド");
    return Text(
      '${state.counter}',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}

class WidgetC extends StatelessWidget {
  const WidgetC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //listen:falseは再描画しない
    final MyHomePageState state = MyHomePageInheritedWidget.of(context,listen:false);
    print("WidgetCをビルド");
    return ElevatedButton(
        onPressed: () {
          state.incrementCounter();
        },
        child: const Text("カウント"));
  }
}
