import 'package:mno_fsm/mno_fsm.dart';

void main() {
  final machine = StateMachine<State, Event, SideEffect>.create((g) => g
    ..initialState(Solid())
    ..state<Solid>((b) => b
      ..on<OnMelted>(
          (Solid s, OnMelted e) => b.transitionTo(Liquid(), LogMelted())))
    ..state<Liquid>((b) => b
      ..onEnter((s) => print('Entering ${s.runtimeType} state'))
      ..onExit((s) => print('Exiting ${s.runtimeType} state'))
      ..on<OnFroze>(
          (Liquid s, OnFroze e) => b.transitionTo(Solid(), LogFrozen()))
      ..on<OnVaporized>(
          (Liquid s, OnVaporized e) => b.transitionTo(Gas(), LogVaporized())))
    ..state<Gas>((b) => b
      ..on<OnCondensed>(
          (Gas s, OnCondensed e) => b.transitionTo(Liquid(), LogCondensed())))
    ..onTransition((t) {
      switch (t.value) {
        case Valid v:
          print(v.sideEffect);
      }
    }));

  print(machine.currentState is Solid); // TRUE

  machine.transition(OnMelted());
  print(machine.currentState is Liquid); // TRUE

  machine.transition(OnFroze());
  print(machine.currentState is Solid); // TRUE
}

abstract class State {}

class Solid extends State {}

class Liquid extends State {}

class Gas extends State {}

abstract class Event {}

class OnMelted extends Event {}

class OnFroze extends Event {}

class OnVaporized extends Event {}

class OnCondensed extends Event {}

abstract class SideEffect {}

class LogMelted extends SideEffect {}

class LogFrozen extends SideEffect {}

class LogVaporized extends SideEffect {}

class LogCondensed extends SideEffect {}
