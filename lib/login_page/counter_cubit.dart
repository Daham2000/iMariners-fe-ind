import 'dart:convert';

import 'package:com_ind_imariners/db/api/auth_api.dart';
import 'package:com_ind_imariners/db/api/category_api.dart';
import 'package:com_ind_imariners/db/models/user_model.dart';
import 'package:com_ind_imariners/utill/shared_memory.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/models/category_model.dart';
import 'counter_state.dart';
import 'super_cubit.dart';

class CounterCubit extends Cubit<CounterState> implements SuperCubit {
  CounterCubit() : super(CounterState.init());

  @override
  Future<int> login(User user) async {
    final String? deviceId = await PlatformDeviceId.getDeviceId;
    user.deviceId = deviceId ?? "";
    DateTime now = DateTime.now();
    user.lastLogin = now.toString();
    final int loginResult = await AuthApi().login(user);
    if (loginResult == 200) {
      await SharedMemory().setUser("user", user.email ?? "");
    }
    return loginResult;
  }

  @override
  Future<int> registerUser(User user) async {
    print(user.email);
    String? deviceId = await PlatformDeviceId.getDeviceId;
    user.deviceId = deviceId;
    int result = await AuthApi().register(user);
    return result;
  }

  void setOffline(ConnectivityResult result) {
    emit(state.clone(isOffline: result == ConnectivityResult.none));
  }

  @override
  Future<int> resetPasswordEmail(User user) async {
    if (state.isDeviceAccReset == true) {
      int result = await AuthApi().resetDeviceEmail(user);
      if (result == 200) {
        emit(state.clone(emailSend: true));
      }
      return result;
    } else {
      int result = await AuthApi().resetPasswordEmail(user);
      if (result == 200) {
        emit(state.clone(emailSend: true));
      }
      return result;
    }
  }

  Future<int> codeCheck(String email, String code) async {
    int result = await AuthApi().checkCode(email, code);
    if (result == 200) {
      if (state.isDeviceAccReset == true) {
        emit(state.clone(
          isDeviceAccReset: false,
          isCodeCorrectResetPass: false,
          isPasswordReset: false,
          emailSend: false,
        ));
      } else {
        emit(state.clone(
          isCodeValid: true,
          isDeviceAccReset: false,
          emailSend: false,
        ));
      }
    }
    return result;
  }

  Future<int> changePassword(String email, String password) async {
    int result = await AuthApi().changePassword(email, password);
    return result;
  }

  setResetPassword() {
    emit(state.clone(isPasswordReset: true, isDeviceAccReset: false));
  }

  changeTheme() {
    emit(state.clone(isDarkMode: !state.isDarkMode));
  }

  setResetDevice() {
    emit(state.clone(
      isDeviceAccReset: true,
      isPasswordReset: true,
    ));
  }

  Future<void> loadCategories(bool isOffline, {String? query}) async {
    emit(state.clone(
      loading: true,
    ));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? categoryList = prefs.getString('category_list');
    if (query == null) {
      if (categoryList != null) {
        final List<Datum> c = Datum.decode(categoryList);
        List<Datum> filterColreg = [];
        if (query == "Colreg") {
          filterColreg =
              c.where((element) => element.categoryName == "Colreg").toList();
          return;
        } else {
          filterColreg =
              c.where((element) => element.categoryName != "Colreg").toList();
        }
        emit(state.clone(
          categoryModel: CategoryModel(
            message: "200",
            data: filterColreg,
          ),
          loading: false,
        ));
        return;
      }
    }
    if (isOffline) {
      emit(state.clone(isOffline: isOffline));
    } else {
      if (categoryList == null) {
        emit(state.clone(
          loading: true,
        ));
      }
      final categories = await CategoryAPI().getAddCategories(query: query);
      emit(state.clone(
        categoryModel: categories,
        loading: false,
      ));
    }
  }

  searchContent(bool isSearching) {
    emit(state.clone(isSearching: isSearching));
  }
}
