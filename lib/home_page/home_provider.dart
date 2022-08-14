import 'package:com_ind_imariners/home_page/home_page_view.dart';
import 'package:com_ind_imariners/login_page/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeProvider extends BlocProvider<CounterCubit> {
  HomeProvider()
      : super(
          create: (context) => CounterCubit(),
          child: const HomePage(),
        );
}
