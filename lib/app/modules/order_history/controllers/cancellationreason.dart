class CancellationReasonModel {
  String id;
  String name;
  String source;

  CancellationReasonModel({
    required this.id,
    required this.name,
    required this.source,
  });

  factory CancellationReasonModel.fromJson(Map<String, dynamic> json) =>
      CancellationReasonModel(
        id: json["id"],
        name: json["name"],
        source: json["source"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "source": source,
      };
}
