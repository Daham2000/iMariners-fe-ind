import 'package:com_ind_imariners/db/api/category_api.dart';
import 'package:flutter/material.dart';

import '../db/models/category_model.dart';
import '../knowlage_base_page/content_expand_view.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final controller = TextEditingController();
  bool isSearching = false;
  CategoryModel categoryList = CategoryModel(data: []);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void loadCategories(String query) async {
    setState(() {
      isSearching = true;
    });
    final CategoryModel c = await CategoryAPI().getAddCategories(query: query);
    setState(() {
      categoryList = c;
      isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size(10, 50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                hoverColor: Colors.white,
                fillColor: Colors.white,
                focusColor: Colors.white,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(
                      right: 2.0, top: 5, bottom: 5, left: 2),
                  child: InkWell(
                    onTap: () {
                      controller.clear();
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
                hintText: "Search for courses",
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 4),
                border: InputBorder.none,
              ),
              onChanged: (query) {
                loadCategories(query);
              },
            ),
          ),
        ),
      ),
      body: isSearching
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : categoryList.data!=null ? ListView.builder(
              itemCount: categoryList.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Future.microtask(() => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ContentExpandView(
                                datum: categoryList.data?[index] ?? Datum(),
                                text: "Knowledge base",
                              )),
                    ));
                  },
                  child: ListTile(
                    leading: const Icon(Icons.list),
                    title: Text("${categoryList.data?[index].categoryName}"),
                  ),
                );
              },
            ) : Container(),
    );
  }
}
