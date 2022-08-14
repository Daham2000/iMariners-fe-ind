import 'package:com_ind_imariners/register_page/register_page_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login_page/counter_cubit.dart';

class RegisterProvider extends BlocProvider<CounterCubit> {
  RegisterProvider()
      : super(
    create: (context) => CounterCubit(),
    child: const RegisterView(),
  );
}
