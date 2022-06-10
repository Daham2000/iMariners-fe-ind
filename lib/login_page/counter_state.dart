import 'package:flutter/cupertino.dart';

@immutable
class CounterState {
  final int count;
  bool isPasswordReset;
  bool isCodeCorrectResetPass;
  bool emailSend;
  bool isCodeValid;

  CounterState({
    required this.count,
    required this.isPasswordReset,
    required this.isCodeCorrectResetPass,
    required this.emailSend,
    required this.isCodeValid,
  });

  CounterState.init()
      : this(
          count: 0,
          isPasswordReset: false,
          isCodeCorrectResetPass: false,
          emailSend: false,
          isCodeValid: false,
        );

  CounterState clone({
    int? count,
    bool? isPasswordReset,
    bool? isCodeCorrectResetPass,
    bool? emailSend,
    bool? isCodeValid,
  }) {
    return CounterState(
      count: count ?? this.count,
      isPasswordReset: isPasswordReset ?? this.isPasswordReset,
      isCodeCorrectResetPass:
          isCodeCorrectResetPass ?? this.isCodeCorrectResetPass,
      emailSend: emailSend ?? this.emailSend,
      isCodeValid: isCodeValid ?? this.isCodeValid,
    );
  }

  static CounterState get initialState => CounterState(
        count: 0,
        isPasswordReset: false,
        isCodeCorrectResetPass: false,
        emailSend: false,
        isCodeValid: false,
      );
}
