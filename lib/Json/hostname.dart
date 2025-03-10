
class HostName {
    // final String? hostname;
    final String name;
    // final String? location;

    HostName({
        // this.hostname,
        // this.location,
        required this.name,
    });

    factory HostName.fromJson(Map<String, dynamic> json) => HostName(
        // hostname: json["hostname"],
        name: json["name"],
        // location: json["location"],
    );

    Map<String, dynamic> toJson() => {
        // "hostname": hostname,
        "name": name,
        // "location": location,
    };
}
