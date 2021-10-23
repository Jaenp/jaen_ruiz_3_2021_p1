class data_anime {

  String anime_id = '';
  String anime_name = '';
  String anime_img = '';

  data_anime({
    required this.anime_id,
    required this.anime_name,
    required this.anime_img
  });

  data_anime.fromJson(Map<String, dynamic> json) {
    anime_id = json['anime_id'];
    anime_name = json['anime_name'];
    anime_img = json['anime_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> request = <String, dynamic>{};
    request['anime_id'] = this.anime_id;
    request['anime_name'] = this.anime_name;
    request['anime_img'] = this.anime_img;
    return request;
  }
}
