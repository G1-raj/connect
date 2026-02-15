class OtpRequest {
    OtpRequest({
        required this.email,
        required this.otp,
    });

    final String? email;
    final String? otp;

    factory OtpRequest.fromJson(Map<String, dynamic> json){ 
        return OtpRequest(
            email: json["email"],
            otp: json["otp"],
        );
    }

    Map<String, dynamic> toJson() => {
        "email": email,
        "otp": otp,
    };

    @override
    String toString(){
        return "$email, $otp, ";
    }
}
