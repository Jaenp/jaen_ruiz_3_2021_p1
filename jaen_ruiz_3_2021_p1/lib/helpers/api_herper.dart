import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jaen_ruiz_3_2021_p1/helpers/constants.dart';
import 'package:jaen_ruiz_3_2021_p1/models/data_animes.dart';
import 'package:jaen_ruiz_3_2021_p1/models/response_api.dart';

class api_helper {

  static Future<response_api> getAllAnime( String id) async {

    var url = Uri.parse(constans.apiUrl);
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

    var decodedJson = jsonDecode(body);
    return response_api(isSuccess: true, result: data_anime.fromJson(decodedJson));
  }
}