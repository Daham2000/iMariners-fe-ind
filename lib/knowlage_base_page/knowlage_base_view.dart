import 'package:com_ind_imariners/db/models/category_model.dart';
import 'package:com_ind_imariners/login_page/counter_cubit.dart';
import 'package:com_ind_imariners/login_page/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../db/api/category_api.dart';
import '../home_page/widget/sample_widget.dart';
import '../main.dart';
import '../theme/colors.dart';
import '../widgets/app_bar_curve.dart';

class KnowledgeBaseView extends StatefulWidget {
  final CategoryModel categoryModel;

  const KnowledgeBaseView({Key? key, required this.categoryModel})
      : super(key: key);

  @override
  _KnowledgeBaseViewState createState() => _KnowledgeBaseViewState();
}

class _KnowledgeBaseViewState extends State<KnowledgeBaseView> {
  late CounterCubit counterCubit;
  final TextEditingController searchFieldCtrl = TextEditingController();
  late CategoryModel searchCategoryModel;
  bool isSearching = false;

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  @override
  void initState() {
    counterCubit = BlocProvider.of<CounterCubit>(context);
    searchCategoryModel = widget.categoryModel;
    super.initState();
  }

  void openDrawer() {
    _key.currentState!.openDrawer();
  }

  void changeTheme() {
    setState(() {
      MyApp.themeNotifier.value = MyApp.themeNotifier.value == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  TextFormField getSearchTextField() {
    return TextFormField(
      controller: searchFieldCtrl,
      cursorColor: Colors.black,
      onChanged: (e) async {
        setState(() {
          isSearching = true;
        });
        final CategoryModel c =
            await CategoryAPI().getAddCategories(query: e.toLowerCase());
        setState(() {
          searchCategoryModel = c;
          isSearching = false;
        });
      },
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderSide: const BorderSide(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(50.0),
          ),
          hintStyle: TextStyle(color: Colors.grey[400]),
          hintText: "Search courses",
          fillColor: Colors.white70),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
          ? ThemeColors.BACKGROUD_COLOR
          : Colors.grey,
      drawer: DrawerApp(
        changeTheme: changeTheme,
      ),
      body: BlocBuilder<CounterCubit, CounterState>(
        buildWhen: (pre, current) =>
            pre.count != current.count ||
            pre.isSearching != current.isSearching,
        builder: (ctx, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppBarCurve(
                  text: "Knowledge Base",
                  isContent: false,
                  openDrawer: openDrawer,
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                                scale: animation, child: child);
                          },
                          child: state.isSearching
                              ? getSearchTextField()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TopicHomePage(
                                      counterCubit: counterCubit,
                                    ),
                                  ],
                                ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "Your Courses",
                            style: GoogleFonts.roboto(
                              fontSize: 19,
                              color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        isSearching
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : searchCategoryModel.data!=null ? Column(
                                children: [
                                  for (int i = 0;
                                      i < searchCategoryModel.data!.length;
                                      i = i + 2)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CategoryViewCard(
                                          datum: searchCategoryModel.data![i],
                                        ),
                                        searchCategoryModel.data!.length > i+1
                                            ? CategoryViewCard(
                                                datum: searchCategoryModel
                                                    .data![i + 1])
                                            : Container(),
                                      ],
                                    ),
                                ],
                              ): Container(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
      // bottomNavigationBar: const BottomNaviBar(),
    );
  }
}
