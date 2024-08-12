
class HostName {
    final String hostname;

    HostName({
        required this.hostname,
    });

    factory HostName.fromJson(Map<String, dynamic> json) => HostName(
        hostname: json["hostname"],
    );

    Map<String, dynamic> toJson() => {
        "hostname": hostname,
    };
}
