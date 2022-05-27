import 'package:com_ind_imariners/home_page/home_page_ui.dart';
import 'package:com_ind_imariners/login_page/login_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../knowlage_base_page/knowlage_base_view.dart';
import '../register_page/register_page_ui.dart';

import 'counter_cubit.dart';

class LoginProvider extends BlocProvider<CounterCubit> {
  LoginProvider()
      : super(
          create: (context) => CounterCubit(),
          child: const KnowlageBaseView(),
        );
}
