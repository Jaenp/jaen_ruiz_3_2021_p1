import 'package:jaen_ruiz_3_2021_p1/models/data_models.dart';

class data_anime {

  bool success = false;
  List<data_anime> data = [];

  data_anime({
   required this.success,
   required this.data
  });

  data_anime.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new data_anime.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> request = <String, dynamic>{};
    request['success'] = this.success;
    request['data'] = this.data.map((v) => v.toJson()).toList();
    return request;
  }

}