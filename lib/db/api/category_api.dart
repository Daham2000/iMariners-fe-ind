import 'dart:convert';

import 'package:com_ind_imariners/db/models/category_model.dart';
import 'package:com_ind_imariners/db/models/telegramModel.dart';
import 'package:http/http.dart' as http;

import '../../utill/strings.dart';

class CategoryAPI {
  Future<CategoryModel> getAddCategories({String? query}) async {
    CategoryModel categoryModel = CategoryModel();
    try {
      var url = Uri.parse('${Strings.url}v1/category');
      if (query != null) {
        String reqQuery = '${query.substring(0,1).toUpperCase()}${query.substring(1,query.length-1)}';
        if(query=="allDownload1010"){
          reqQuery = '${query}';
        }
        final queryParameters = {
          'query': reqQuery,
        };
        url = Uri.https('${Strings.url2}', "v1/category", queryParameters);
        print(url);
      }else{
        final queryParameters = {
          'query': '',
        };
        url = Uri.https('${Strings.url2}', "v1/category", queryParameters);
      }
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final jsonString = response.body;
        print(jsonString);
        final jsonMap = json.decode(jsonString);
        categoryModel = CategoryModel.fromJson(jsonMap);
      }
      return categoryModel;
    } catch (e) {
      print(e.toString());
      return categoryModel;
    }
  }

  Future<TelegramModel> getGroups() async {
    final url = Uri.parse('${Strings.url}v1/groups');
    TelegramModel telegramModel = TelegramModel();
    try {
      final response =
          await http.get(url, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        final jsonString = response.body;
        final jsonMap = json.decode(jsonString);
        telegramModel = TelegramModel.fromJson(jsonMap);
      }
      return telegramModel;
    } catch (e) {
      return telegramModel;
    }
  }
}
