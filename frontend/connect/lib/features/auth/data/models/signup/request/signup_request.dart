class SignupRequest {
    SignupRequest({
        required this.email,
        required this.fullName,
    });

    final String? email;
    final String? fullName;

    factory SignupRequest.fromJson(Map<String, dynamic> json){ 
        return SignupRequest(
            email: json["email"],
            fullName: json["full_name"],
        );
    }

    Map<String, dynamic> toJson() => {
        "email": email,
        "full_name": fullName,
    };

    @override
    String toString(){
        return "$email, $fullName, ";
    }
}
