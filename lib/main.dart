import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_state_exer/screen/my_home_page.dart';
import 'package:flutter_state_exer/state/my_home_state.dart';
import 'package:flutter_state_exer/view_model/my_home_view_model.dart';

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

//providerをグローバルに定義することができる
final myHomePageProvider = StateNotifierProvider<MyHomePageStateNotifier,MyHomePageState>
  ((ref)=>MyHomePageStateNotifier());



