import  'dart:convert';

ListP listPFromJson(String str) => ListP.fromJson(json.decode(str));

String listPToJson(ListP data) => json.encode(data.toJson());

class ListP {
    final String name;

    ListP({
        required this.name,
    });

    factory ListP.fromJson(Map<String, dynamic> json) => ListP(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}
