class OrderModel {
  String detail;
  dynamic approvedAt;
  dynamic approved;
  String createdAt;
  dynamic delivered;
  dynamic deliveredAt;
  dynamic deliveryApproved;
  String deliveryLocation;
  String id;
  dynamic orderStatus;
  dynamic orderId;
  String pickupLocation;

  OrderModel({
    required this.detail,
    this.approvedAt,
    this.approved,
    required this.createdAt,
    this.delivered,
    this.deliveredAt,
    this.deliveryApproved,
    required this.deliveryLocation,
    required this.id,
    this.orderStatus,
    this.orderId,
    required this.pickupLocation,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      detail: json['detail'],
      approvedAt: json['approved_at'],
      approved: json['approved'],
      createdAt: json['created_at'],
      delivered: json['delivered'],
      deliveredAt: json['delivered_at'],
      deliveryApproved: json['delivery_approved'],
      deliveryLocation: json['delivery_location'],
      orderStatus: json['order_status'],
      orderId: json['order_id'],
      pickupLocation: json['pickup_location'],
    );
  }

  get length => null;

  Map<String, dynamic> toJson() => {
        "detail": detail,
        "approved_at": approvedAt,
        "approved": approved,
        "created_at": createdAt,
        "delivered": delivered,
        "delivered_at": deliveredAt,
        "delivery_approved": deliveryApproved,
        "delivery_location": deliveryLocation,
        "id": id,
        "order_status": orderStatus,
        "order_id": orderId,
        "pickup_location": pickupLocation,
      };
}
