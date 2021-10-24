class get_anime_details {
  String details = '';

  get_anime_details(
    { 
    required this.details});

  get_anime_details.fromJson(Map<String, dynamic> json) {
    details = json['fact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fact'] = this.details;
    return data;
  }
}