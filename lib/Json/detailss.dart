class DetailsS {
    final String? id;
    final String? idArea;
    final String? location;
    final String? serial;
    final String? marca;
    final String? tipo;
    final String? fechaLlegada;
    final String? usuario;
    final DateTime? fechaEntrega;

    DetailsS({
        this.id,
        this.idArea,
        this.location,
        this.serial,
        this.marca,
        this.tipo,
        this.fechaLlegada,
        this.usuario,
        this.fechaEntrega,
    });

    factory DetailsS.fromJson(Map<String, dynamic> json) => DetailsS(
        id: json["id"],
        idArea: json["id_area"],
        location: json["location"],
        serial: json["serial"],
        marca: json["marca"],
        tipo: json["tipo"],
        fechaLlegada: json["fecha_llegada"],
        usuario: json["usuario"],
        fechaEntrega: json["fecha_entrega"] == null ? null : DateTime.parse(json["fecha_entrega"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_area": idArea,
        "location": location,
        "serial": serial,
        "marca": marca,
        "tipo": tipo,
        "fecha_llegada": fechaLlegada,
        "usuario": usuario,
        "fecha_entrega": "${fechaEntrega!.year.toString().padLeft(4, '0')}-${fechaEntrega!.month.toString().padLeft(2, '0')}-${fechaEntrega!.day.toString().padLeft(2, '0')}",
    };
}
