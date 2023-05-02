// ignore_for_file: non_constant_identifier_names

class NotificationtModel {
  late int id;
  late String title;
  late String body;

  late bool read;
  late String created_at;

  NotificationtModel({
    required this.title,
    required this.body,
    required this.id,
    required this.read,
    required this.created_at,
  });
}
