import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jaen_ruiz_3_2021_p1/helpers/constants.dart';
import 'package:jaen_ruiz_3_2021_p1/models/get_all.dart';
import 'package:jaen_ruiz_3_2021_p1/models/get_anime_details.dart';
import 'package:jaen_ruiz_3_2021_p1/models/response_api.dart';

class api_helper_anime {

  static Future<response_api> getAllAnime() async {

    var url = Uri.parse('${constans.apiUrl}');
    var response = await http.get(
      url,
      headers: {
        'content-type' : 'application/json',
        'accept' : 'application/json',
      },
    );

    var body = response.body;
    if (response.statusCode >= 400) {
      return response_api(isSuccess: false, message: body);
    }

    List<get_all> list = [];
    var decodedJson = jsonDecode(body);
    if (decodedJson != null) {
      for (var item in decodedJson['data']) {
        list.add(get_all.fromJson(item));
      }
    }
    return response_api(isSuccess: true, result: list);
  }

  static Future<response_api> getAnime(String anime_name) async {
    var url = Uri.parse('${constans.apiUrl}/$anime_name');
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );

    var body = response.body;
    if (response.statusCode >= 400) {
      return response_api(isSuccess: false, message: body);
    }

    List<get_anime_details> list = [];
    var decodedJson = jsonDecode(body);
    if (decodedJson != null) {
      for (var item in decodedJson['data']) {
        list.add(get_anime_details.fromJson(item));
      }
    }

    return response_api(isSuccess: true, result: list);
  }
}