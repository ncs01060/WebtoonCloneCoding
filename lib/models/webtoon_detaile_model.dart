class WebtoonDetaileModel {
  final String title, about, genre, age;

  WebtoonDetaileModel.formJson(Map<String, dynamic> json)
    : title = json['title'],
      about = json['about'],
      genre = json['genre'],
      age = json['age'];
}
