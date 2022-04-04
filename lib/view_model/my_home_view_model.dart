import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_state_exer/state/my_home_state.dart';

//ここにはstateのロジックを書く
//ロジックとはstateに対して何か付け加える行為
class MyHomePageStateNotifier extends StateNotifier<MyHomePageState> {
  MyHomePageStateNotifier() : super(const MyHomePageState());

  void increment() {
    //stateとはMyHomePageStateの事をさす
    //copyWithは上書きをするという意味
    state = state.copyWith(state.counter + 1);
  }
}
