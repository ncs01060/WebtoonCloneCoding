import 'dart:convert';

import 'package:first_app/models/webtoon_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseURL =
      'https://webtoon-crawler.nomadcoders.workers.dev';
  static const String today = "today";

  Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseURL/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.formJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }
}
