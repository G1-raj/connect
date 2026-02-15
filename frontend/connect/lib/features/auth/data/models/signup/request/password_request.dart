class PasswordRequest {
    PasswordRequest({
        required this.password,
    });

    final String? password;

    factory PasswordRequest.fromJson(Map<String, dynamic> json){ 
        return PasswordRequest(
            password: json["password"],
        );
    }

    Map<String, dynamic> toJson() => {
        "password": password,
    };

    @override
    String toString(){
        return "$password, ";
    }
}
