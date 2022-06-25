import 'package:com_ind_imariners/db/models/category_model.dart';
import 'package:com_ind_imariners/knowlage_base_page/knowlage_base_view.dart';
import 'package:com_ind_imariners/login_page/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KnowlageBaseProvider extends BlocProvider<CounterCubit> {
  KnowlageBaseProvider({required CategoryModel categoryModel})
      : super(
          create: (context) => CounterCubit(),
          child: KnowledgeBaseView(categoryModel: categoryModel),
        );
}
