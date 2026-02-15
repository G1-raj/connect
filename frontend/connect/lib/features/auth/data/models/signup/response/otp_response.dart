class OtpResponse {
    OtpResponse({
        required this.onboardingToken,
        required this.message,
    });

    final String? onboardingToken;
    final String? message;

    factory OtpResponse.fromJson(Map<String, dynamic> json){ 
        return OtpResponse(
            onboardingToken: json["onboarding_token"],
            message: json["message"],
        );
    }

    Map<String, dynamic> toJson() => {
        "onboarding_token": onboardingToken,
        "message": message,
    };

    @override
    String toString(){
        return "$onboardingToken, $message, ";
    }
}
