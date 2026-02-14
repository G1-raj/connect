class LoginRequest {
    LoginRequest({
        required this.email,
        required this.password,
    });

    final String? email;
    final String? password;

    factory LoginRequest.fromJson(Map<String, dynamic> json){ 
        return LoginRequest(
            email: json["email"],
            password: json["password"],
        );
    }

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
    };

    @override
    String toString(){
        return "$email, $password, ";
    }
}
