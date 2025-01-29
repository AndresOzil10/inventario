
class Printer {
    // final String? Printer;
    final String name;
    // final String? location;

    Printer({
        // this.Printer,
        // this.location,
        required this.name,
    });

    factory Printer.fromJson(Map<String, dynamic> json) => Printer(
        // Printer: json["Printer"],
        name: json["name"],
        // location: json["location"],
    );

    Map<String, dynamic> toJson() => {
        // "Printer": Printer,
        "name": name,
        // "location": location,
    };
}