class CreateProfileRequest {
    CreateProfileRequest({
        required this.gender,
        required this.description,
        required this.sexuality,
        required this.dateOfBirth,
        required this.longitude,
        required this.latitude,
        required this.interests,
    });

    final String? gender;
    final String? description;
    final String? sexuality;
    final DateTime? dateOfBirth;
    final double? longitude;
    final double? latitude;
    final List<String> interests;

    factory CreateProfileRequest.fromJson(Map<String, dynamic> json){ 
        return CreateProfileRequest(
            gender: json["gender"],
            description: json["description"],
            sexuality: json["sexuality"],
            dateOfBirth: DateTime.tryParse(json["date_of_birth"] ?? ""),
            longitude: json["longitude"],
            latitude: json["latitude"],
            interests: json["interests"] == null ? [] : List<String>.from(json["interests"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "gender": gender,
        "description": description,
        "sexuality": sexuality,
        "date_of_birth": "${dateOfBirth?.year.toString().padLeft(4, '0')}-${dateOfBirth?.month.toString().padLeft(2, '0')}-${dateOfBirth?.day.toString().padLeft(2, '0')}",
        "longitude": longitude,
        "latitude": latitude,
        "interests": interests.map((x) => x).toList(),
    };

    @override
    String toString(){
        return "$gender, $description, $sexuality, $dateOfBirth, $longitude, $latitude, $interests, ";
    }
}
