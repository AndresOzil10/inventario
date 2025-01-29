
class Details {
    final String id;
    final String? tipo;
    final String? usuario;
    final String? nombre;
    final String? serie;
    final DateTime? fechaInicioEquipo;
    final DateTime? fechaFinalGarantia;
    final String? estatusGarantia;
    final String? docking;
    final String? diadema;
    final String? monitor;
    final String? tecladoMouse;
    final String? camara;
    final String? otros;
    final String? area;

    Details({
        required this.id,
        this.tipo,
        this.serie,
        this.usuario,
        this.nombre,
        this.fechaInicioEquipo,
        this.fechaFinalGarantia,
        this.estatusGarantia,
        this.docking,
        this.diadema,
        this.monitor,
        this.tecladoMouse,
        this.camara,
        this.otros,
        this.area,
    });

    factory Details.fromJson(Map<String, dynamic> json) => Details(
        id: json["id"],
        tipo: json["tipo"],
        serie: json["serie"],
        usuario: json["usuario"],
        nombre: json["nombre"],
        fechaInicioEquipo: DateTime.parse(json["fecha_inicio"]),
        fechaFinalGarantia: DateTime.parse(json["fecha_final_garantia"]),
        estatusGarantia: json["estatus_garantia"],
        docking: json["docking"],
        diadema: json["diadema"],
        monitor: json["monitor"],
        tecladoMouse: json["teclado_mouse"],
        camara: json["camara"],
        otros: json["otros"],
        area: json["area"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "serie": serie,
        "usuario": usuario,
        "nombre": nombre,
        "fecha_inicio_equipo": fechaInicioEquipo,
        "fecha_final_garantia": "${fechaFinalGarantia!.year.toString().padLeft(4, '0')}-${fechaFinalGarantia!.month.toString().padLeft(2, '0')}-${fechaFinalGarantia!.day.toString().padLeft(2, '0')}",
        "estatus_garantia": estatusGarantia,
        "docking": docking,
        "diadema": diadema,
        "monitor": monitor,
        "teclado_mouse": tecladoMouse,
        "camara": camara,
        "otros": otros,
        "area": area,
    };
}


