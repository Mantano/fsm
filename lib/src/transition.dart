part of 'state_machine.dart';

/// Defines FSM transition: the change from one state to another.
class Transition<STATE, EVENT, SIDE_EFFECT> {
  const Transition._(this._value);

  final Coproduct2<Valid<STATE, EVENT, SIDE_EFFECT>, Invalid<STATE, EVENT>>
      _value;

  Transition.valid(
    STATE fromState,
    EVENT event,
    STATE toState,
    SIDE_EFFECT? sideEffect,
  ) : this._(Coproduct2.item1(Valid(fromState, event, toState, sideEffect)));

  Transition.invalid(STATE state, EVENT event)
      : this._(Coproduct2.item2(Invalid(state, event)));

  R match<R>(
    R Function(Valid<STATE, EVENT, SIDE_EFFECT>) ifFirst,
    R Function(Invalid<STATE, EVENT>) ifSecond,
  ) =>
      _value.fold(ifFirst, ifSecond);

  @override
  String toString() => 'Transition{_value: $_value}';
}

/// Valid transition meaning that machine goes from [fromState]
/// to [toState]. Transition is caused by [event].
///
/// It contains optional [sideEffect].
class Valid<STATE, EVENT, SIDE_EFFECT> {
  Valid(this.fromState, this.event, this.toState, this.sideEffect);

  final STATE fromState;
  final EVENT event;
  final STATE toState;
  final SIDE_EFFECT? sideEffect;

  @override
  String toString() =>
      'Valid{fromState: $fromState, event: $event, toState: $toState, sideEffect: $sideEffect}';
}

/// Invalid transition called by [event]. Machine stays in [state].
class Invalid<STATE, EVENT> {
  Invalid(this.fromState, this.event);

  final STATE fromState;
  final EVENT event;

  @override
  String toString() => 'Invalid{fromState: $fromState, event: $event}';
}
