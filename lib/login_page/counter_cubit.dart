import 'package:com_ind_imariners/db/api/auth_api.dart';
import 'package:com_ind_imariners/db/models/user_model.dart';
import 'package:com_ind_imariners/utill/shared_memory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_device_id/platform_device_id.dart';

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
    final int loginResult = await AuthApi().login(user, "user");
    SharedMemory().setUser("user", user.email ?? "");
    return loginResult;
  }

  @override
  Future<int> registerUser(User user) async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    user.deviceId = deviceId;
    int result = await AuthApi().register(user);
    return result;
  }

  @override
  Future<int> resetPasswordEmail(User user) async {
    int result = await AuthApi().resetPasswordEmail(user);
    if (result == 200) {
      emit(state.clone(emailSend: true));
    }
    return result;
  }

  Future<int> codeCheck(String email, String code) async {
    int result = await AuthApi().checkCode(email, code);
    if (result == 200) {
      emit(state.clone(
        isCodeValid: true,
      ));
    }
    return result;
  }

  setResetPassword() {
    emit(state.clone(isPasswordReset: true));
  }
}
