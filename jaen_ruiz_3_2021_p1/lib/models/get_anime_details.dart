class get_anime_details {
  //int id = 0;
  String details = '';

  get_anime_details(
    {//required this.id, 
    required this.details});

  get_anime_details.fromJson(Map<String, dynamic> json) {
    //id = json['id'];
    details = json['fact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['id'] = this.id;
    data['fact'] = this.details;
    return data;
  }
}