   class DetailsP {
    final String? id;
    final String? idArea;
    final String? location;
    final String? serial;
    final String? name;
    final String? ip;
    final String? mac;
    final String? tipo;
    final String? observation;

    DetailsP({
        this.id,
        this.idArea,
        this.location,
        this.serial,
        this.name,
        this.ip,
        this.mac,
        this.tipo,
        this.observation,
    });

    factory DetailsP.fromJson(Map<String, dynamic> json) => DetailsP(
        id: json["id"],
        idArea: json["id_area"],
        location: json["location"],
        serial: json["serial"],
        name: json["name"],
        ip: json["ip"],
        mac: json["mac"],
        tipo: json["tipo"],
        observation: json["observation"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_area": idArea,
        "location": location,
        "serial": serial,
        "name": name,
        "ip": ip,
        "mac": mac,
        "tipo": tipo,
        "observation": observation,
    };
}
