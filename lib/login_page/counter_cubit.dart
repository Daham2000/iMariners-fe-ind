import 'package:com_ind_imariners/db/api/auth_api.dart';
import 'package:com_ind_imariners/db/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_device_id/platform_device_id.dart';

import 'counter_state.dart';
import 'super_cubit.dart';

class CounterCubit extends Cubit<CounterState> implements SuperCubit {
  CounterCubit() : super(CounterState.init());

  @override
  Future<int> login(User user) async {
    final String? deviceId = await PlatformDeviceId.getDeviceId;
    user.deviceId = deviceId??"";
    DateTime now = DateTime.now();
    user.lastLogin = now.toString();
    final int loginResult = await AuthApi().login(user, "user");
    return loginResult;
  }

  @override
  Future<bool> registerUser(User user) async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    user.deviceId = deviceId;
    bool result = await AuthApi().register(user);
    return result;
  }
}
