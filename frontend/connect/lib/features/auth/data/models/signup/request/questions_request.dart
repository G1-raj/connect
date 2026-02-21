class QuestionsRequest {
  final bool alcohol;
  final bool smoke;
  final bool kids;
  final bool pets;
  final bool exercise;

  QuestionsRequest({
    required this.alcohol,
    required this.smoke,
    required this.kids,
    required this.pets,
    required this.exercise,
  });

  factory QuestionsRequest.fromJson(Map<String, dynamic> json) {
    return QuestionsRequest(
      alcohol: json["alcohol"],
      smoke: json["smoke"],
      kids: json["kids"],
      pets: json["pets"],
      exercise: json["exercise"],
    );
  }

  Map<String, dynamic> toJson() => {
    "alcohol": alcohol,
    "smoke": smoke,
    "pets": pets,
    "kids": kids,
    "exercise": exercise,
  };
}
