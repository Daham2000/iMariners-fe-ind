import 'package:com_ind_imariners/login_page/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'tools_view.dart';

class ToolsProvider extends BlocProvider<CounterCubit> {
  ToolsProvider()
      : super(
    create: (context) => CounterCubit(),
    child: const ToolsView(),
  );
}
