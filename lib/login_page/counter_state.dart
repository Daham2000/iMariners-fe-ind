import 'package:flutter/cupertino.dart';

import '../db/models/category_model.dart';

@immutable
class CounterState {
  final int count;
  bool isPasswordReset;
  bool loading;
  bool isDeviceAccReset;
  bool isCodeCorrectResetPass;
  bool emailSend;
  bool isCodeValid;
  CategoryModel categoryModel;

  CounterState({
    required this.count,
    required this.isPasswordReset,
    required this.loading,
    required this.isDeviceAccReset,
    required this.isCodeCorrectResetPass,
    required this.emailSend,
    required this.isCodeValid,
    required this.categoryModel,
  });

  CounterState.init()
      : this(
          count: 0,
          isPasswordReset: false,
          loading: false,
          isDeviceAccReset: false,
          isCodeCorrectResetPass: false,
          emailSend: false,
          isCodeValid: false,
          categoryModel: CategoryModel(),
        );

  CounterState clone({
    int? count,
    bool? isPasswordReset,
    bool? loading,
    bool? isDeviceAccReset,
    bool? isCodeCorrectResetPass,
    bool? emailSend,
    bool? isCodeValid,
    CategoryModel? categoryModel,
  }) {
    return CounterState(
      count: count ?? this.count,
      categoryModel: categoryModel ?? this.categoryModel,
      isPasswordReset: isPasswordReset ?? this.isPasswordReset,
      loading: loading ?? this.loading,
      isDeviceAccReset: isDeviceAccReset ?? this.isDeviceAccReset,
      isCodeCorrectResetPass:
          isCodeCorrectResetPass ?? this.isCodeCorrectResetPass,
      emailSend: emailSend ?? this.emailSend,
      isCodeValid: isCodeValid ?? this.isCodeValid,
    );
  }

  static CounterState get initialState => CounterState(
        count: 0,
        categoryModel: CategoryModel(),
        isPasswordReset: false,
        loading: false,
        isDeviceAccReset: false,
        isCodeCorrectResetPass: false,
        emailSend: false,
        isCodeValid: false,
      );
}
