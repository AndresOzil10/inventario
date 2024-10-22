
class Details {
    final String id;
    final String tipo;
    final String serial;
    final String hostname;
    final String usuario;
    final String nombre;
    final String serie;
    final DateTime fechaInicioEquipo;
    final DateTime fechaFinalGarantia;
    final String diasFinGarantia;
    final String estatusGarantia;
    final String vidaUtil;
    final String docking;
    final String diadema;
    final String monitor;
    final String tecladoMouse;
    final String camara;
    final String otros;
    final String area;

    Details({
        required this.id,
        required this.tipo,
        required this.serial,
        required this.hostname,
        required this.usuario,
        required this.nombre,
        required this.serie,
        required this.fechaInicioEquipo,
        required this.fechaFinalGarantia,
        required this.diasFinGarantia,
        required this.estatusGarantia,
        required this.vidaUtil,
        required this.docking,
        required this.diadema,
        required this.monitor,
        required this.tecladoMouse,
        required this.camara,
        required this.otros,
        required this.area,
    });

    factory Details.fromJson(Map<String, dynamic> json) => Details(
        id: json["id"],
        tipo: json["tipo"],
        serial: json["serial"],
        hostname: json["hostname"],
        usuario: json["usuario"],
        nombre: json["nombre"],
        serie: json["serie"],
        fechaInicioEquipo: DateTime.parse(json["fecha_inicio_equipo"]),
        fechaFinalGarantia: DateTime.parse(json["fecha_final_garantia"]),
        diasFinGarantia: json["dias_fin_garantia"],
        estatusGarantia: json["estatus_garantia"],
        vidaUtil: json["vida_util"],
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
        "serial": serial,
        "hostname": hostname,
        "usuario": usuario,
        "nombre": nombre,
        "serie": serie,
        "fecha_inicio_equipo": fechaInicioEquipo,
        "fecha_final_garantia": "${fechaFinalGarantia.year.toString().padLeft(4, '0')}-${fechaFinalGarantia.month.toString().padLeft(2, '0')}-${fechaFinalGarantia.day.toString().padLeft(2, '0')}",
        "dias_fin_garantia": diasFinGarantia,
        "estatus_garantia": estatusGarantia,
        "vida_util": vidaUtil,
        "docking": docking,
        "diadema": diadema,
        "monitor": monitor,
        "teclado_mouse": tecladoMouse,
        "camara": camara,
        "otros": otros,
        "area": area,
    };
}


