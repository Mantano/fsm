part of 'state_machine.dart';

/// Defines FSM transition: the change from one state to another.
class Transition<STATE, EVENT, SIDE_EFFECT> {
  const Transition._(this._value);

  final ValidOrInvalid<STATE, EVENT, SIDE_EFFECT>_value;

  Transition.valid(
    STATE fromState,
    EVENT event,
    STATE toState,
    SIDE_EFFECT? sideEffect,
  ) : this._(Valid(fromState, event, toState, sideEffect));

  Transition.invalid(STATE state, EVENT event)
      : this._(Invalid(state, event));

  get value => _value;

  @override
  String toString() => 'Transition{_value: $_value}';
}

sealed class ValidOrInvalid<STATE, EVENT, SIDE_EFFECT> {
  ValidOrInvalid();
}

/// Valid transition meaning that machine goes from [fromState]
/// to [toState]. Transition is caused by [event].
///
/// It contains optional [sideEffect].
class Valid<STATE, EVENT, SIDE_EFFECT> extends ValidOrInvalid<STATE, EVENT, SIDE_EFFECT> {
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
class Invalid<STATE, EVENT, SIDE_EFFECT> extends ValidOrInvalid<STATE, EVENT, SIDE_EFFECT> {
  Invalid(this.fromState, this.event);

  final STATE fromState;
  final EVENT event;

  @override
  String toString() => 'Invalid{fromState: $fromState, event: $event}';
}
