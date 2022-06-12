import 'dart:convert';

import 'package:com_ind_imariners/db/models/category_model.dart';
import 'package:http/http.dart' as http;

import '../../utill/strings.dart';

class CategoryAPI {

  Future<CategoryModel> getAddCategories() async {
    final url = Uri.parse('${Strings.url}v1/category');
    CategoryModel categoryModel = CategoryModel();
    try {
      final response = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json'
          }
      );
      if (response.statusCode == 200) {
        final jsonString = response.body;
        final jsonMap = json.decode(jsonString);
        categoryModel = CategoryModel.fromJson(jsonMap);
      }
      return categoryModel;
    }catch(e){
      return categoryModel;
    }
  }


}
