class LoginResponse {
    LoginResponse({
        required this.message,
        required this.data,
        required this.token,
    });

    final String? message;
    final Data? data;
    final Token? token;

    factory LoginResponse.fromJson(Map<String, dynamic> json){ 
        return LoginResponse(
            message: json["message"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
            token: json["token"] == null ? null : Token.fromJson(json["token"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
        "token": token?.toJson(),
    };

    @override
    String toString(){
        return "$message, $data, $token, ";
    }
}

class Data {
    Data({
        required this.id,
        required this.email,
        required this.fullName,
        required this.description,
        required this.dateOfBirth,
        required this.gender,
        required this.sexuality,
        required this.isEmailVerified,
        required this.latitude,
        required this.longitude,
        required this.interests,
        required this.images,
        required this.alcohol,
        required this.smoke,
        required this.pets,
        required this.kids,
        required this.exercise,
        required this.age,
    });

    final int? id;
    final String? email;
    final String? fullName;
    final String? description;
    final DateTime? dateOfBirth;
    final String? gender;
    final String? sexuality;
    final bool? isEmailVerified;
    final double? latitude;
    final double? longitude;
    final List<String> interests;
    final List<Image> images;
    final bool? alcohol;
    final bool? smoke;
    final bool? pets;
    final bool? kids;
    final bool? exercise;
    final int? age;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            id: json["id"],
            email: json["email"],
            fullName: json["full_name"],
            description: json["description"],
            dateOfBirth: DateTime.tryParse(json["date_of_birth"] ?? ""),
            gender: json["gender"],
            sexuality: json["sexuality"],
            isEmailVerified: json["is_email_verified"],
            latitude: json["latitude"],
            longitude: json["longitude"],
            interests: json["interests"] == null ? [] : List<String>.from(json["interests"]!.map((x) => x)),
            images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
            alcohol: json["alcohol"],
            smoke: json["smoke"],
            pets: json["pets"],
            kids: json["kids"],
            exercise: json["exercise"],
            age: json["age"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "full_name": fullName,
        "description": description,
        "date_of_birth": "${dateOfBirth?.year.toString().padLeft(4,'0')}-${dateOfBirth?.month.toString().padLeft(2,'0')}-${dateOfBirth?.day.toString().padLeft(2,'0')}",
        "gender": gender,
        "sexuality": sexuality,
        "is_email_verified": isEmailVerified,
        "latitude": latitude,
        "longitude": longitude,
        "interests": interests.map((x) => x).toList(),
        "images": images.map((x) => x?.toJson()).toList(),
        "alcohol": alcohol,
        "smoke": smoke,
        "pets": pets,
        "kids": kids,
        "exercise": exercise,
        "age": age,
    };

    @override
    String toString(){
        return "$id, $email, $fullName, $description, $dateOfBirth, $gender, $sexuality, $isEmailVerified, $latitude, $longitude, $interests, $images, $alcohol, $smoke, $pets, $kids, $exercise, $age, ";
    }
}

class Image {
    Image({
        required this.publicId,
        required this.imageUrl,
    });

    final String? publicId;
    final String? imageUrl;

    factory Image.fromJson(Map<String, dynamic> json){ 
        return Image(
            publicId: json["public_id"],
            imageUrl: json["image_url"],
        );
    }

    Map<String, dynamic> toJson() => {
        "public_id": publicId,
        "image_url": imageUrl,
    };

    @override
    String toString(){
        return "$publicId, $imageUrl, ";
    }
}

class Token {
    Token({
        required this.accessToken,
        required this.refreshToken,
    });

    final String? accessToken;
    final String? refreshToken;

    factory Token.fromJson(Map<String, dynamic> json){ 
        return Token(
            accessToken: json["access_token"],
            refreshToken: json["refresh_token"],
        );
    }

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
    };

    @override
    String toString(){
        return "$accessToken, $refreshToken, ";
    }
}
