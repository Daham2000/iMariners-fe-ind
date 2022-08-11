import 'package:shared_preferences/shared_preferences.dart';

import '../db/api/category_api.dart';
import '../db/models/category_model.dart';
import 'package:http/http.dart' as http;

class OfflineCtrl {
  void downloadAllContent() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final categories =
        await CategoryAPI().getAddCategories(query: "allDownload1010");
    await prefs.remove('category_list');
    for (int i = 0; i < categories.data!.length; i++) {
      for (int j = 0; j < categories.data![i].subCategories!.length; j++) {
        //Download category contents
        if (categories
            .data![i].subCategories![j].categoryContentLink!.isNotEmpty) {
          if (categories.data![i].subCategories![j].categoryContentLink![0]
              .startsWith("https://")) {
            final url = Uri.parse(
                '${categories.data![i].subCategories![j].categoryContentLink![0]}');
            final response = await http.get(url);
            if (response.body != null) {
              categories.data![i].subCategories![j].categoryContentLink![0] =
                  response.body;
            }
          }
        }
        //Download subcategory content
        for (int q = 0;
            q < categories.data![i].subCategories![j].subCategories!.length;
            q++) {
          if (categories
              .data![i].subCategories![j].subCategories![q].categoryContentLink!
              .startsWith("https://")) {
            final url = Uri.parse(
                '${categories.data![i].subCategories![j].subCategories?[q].categoryContentLink}');
            final response = await http.get(url);
            if (response.body != null) {
              categories.data![i].subCategories![j].subCategories?[q]
                  .categoryContentLink = response.body;
            }
          }

          //Subcategory topic download
          for (int t = 0;
              t <
                  categories.data![i].subCategories![j].subCategories![q]
                      .topicSubCategories!.length;
              t++) {
            if (categories.data![i].subCategories![j].subCategories![q]
                .topicSubCategories![t].categoryContentLink!
                .startsWith("https://")) {
              final url = Uri.parse(
                  '${categories.data![i].subCategories![j].subCategories![q].topicSubCategories![t].categoryContentLink}');
              final response = await http.get(url);
              if (response.body != null) {
                categories.data![i].subCategories![j].subCategories![q]
                    .topicSubCategories![t].categoryContentLink = response.body;
              }
            }
          }
        }
      }
    }
    //Save the list in the cache memory
    final String encodedData = Datum.encode(categories.data ?? []);
    await prefs.setString('category_list', encodedData);
  }
}
