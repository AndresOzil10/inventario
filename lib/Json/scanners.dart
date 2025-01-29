class Scanner {
    // final String? Scanner;
    final String serial;
    // final String? location;

    Scanner({
        // this.Scanner,
        // this.location,
        required this.serial,
    });

    factory Scanner.fromJson(Map<String, dynamic> json) => Scanner(
        // Scanner: json["Scanner"],
        serial: json["serial"],
        // location: json["location"],
    );

    Map<String, dynamic> toJson() => {
        // "Scanner": Scanner,
        "serial": serial,
        // "location": location,
    };
}