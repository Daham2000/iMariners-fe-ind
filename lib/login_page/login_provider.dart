import 'package:com_ind_imariners/login_page/login_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_cubit.dart';

class LoginProvider extends BlocProvider<CounterCubit> {
  LoginProvider()
      : super(
          create: (context) => CounterCubit(),
          child: const LoginView(),
        );
}
