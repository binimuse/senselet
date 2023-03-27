// ignore_for_file: non_constant_identifier_names

class OrderHistoryModel {
  late int id;
  late double delivery_fee;
  late String status;
  late double other_fees;
  late double tax;
  late double order_total;
  late String created_at;
  late double total;
  late String placeName;
  late String placeAddress;
  final List<OrderHistoryItemsModel> orderHistoryItemsModel;

  OrderHistoryModel({
    required this.id,
    required this.delivery_fee,
    required this.status,
    required this.other_fees,
    required this.tax,
    required this.created_at,
    required this.order_total,
    required this.total,
    required this.placeName,
    required this.placeAddress,
    required this.orderHistoryItemsModel,
  });
}

class OrderHistoryItemsModel {
  late int id;
  late String created_at;
  late int quantity;
  late int variant_id;
  late double variant_Price;
  late int prodact_id;
  late String prodact_name;
  late String prodact_images;

  OrderHistoryItemsModel({
    required this.id,
    required this.created_at,
    required this.quantity,
    required this.variant_id,
    required this.variant_Price,
    required this.prodact_id,
    required this.prodact_name,
    required this.prodact_images,
  });
}
