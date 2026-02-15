class MessageResponse {
    MessageResponse({
        required this.message,
    });

    final String? message;

    factory MessageResponse.fromJson(Map<String, dynamic> json){ 
        return MessageResponse(
            message: json["message"],
        );
    }

    Map<String, dynamic> toJson() => {
        "message": message,
    };

    @override
    String toString(){
        return "$message, ";
    }
}
