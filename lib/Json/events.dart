
class Events {
    final String fechaHora;
    final String namePrinter;

    Events({
        required this.fechaHora,
        required this.namePrinter,
    });

    factory Events.fromJson(Map<String, dynamic> json) => Events(
        fechaHora: json["fechaHora"],
        namePrinter: json["namePrinter"],
    );

    Map<String, dynamic> toJson() => {
        "fechaHora": fechaHora,
        "namePrinter": namePrinter,
    };
}
