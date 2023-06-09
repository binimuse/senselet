class OrderModel {
  String detail;
  dynamic approvedAt;
  dynamic approved;
  String createdAt;
  dynamic delivered;
  dynamic deliveredAt;
  dynamic deliveryApproved;
  String id;
  dynamic orderStatus;
  dynamic orderId;
  String deliverylocationname;
  String pickuplocationname;

  OrderModel({
    required this.detail,
    this.approvedAt,
    this.approved,
    required this.createdAt,
    this.delivered,
    this.deliveredAt,
    this.deliveryApproved,
    required this.id,
    this.orderStatus,
    this.orderId,
    required this.deliverylocationname,
    required this.pickuplocationname,
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
      deliverylocationname: json['delivery_location_name'],
      orderStatus: json['order_status'],
      orderId: json['order_id'],
      pickuplocationname: json['pickup_location_name'],
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
        "delivery_location_name": deliverylocationname,
        "id": id,
        "order_status": orderStatus,
        "order_id": orderId,
        "pickup_location_name": pickuplocationname,
      };

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      detail: map['detail'],
      approvedAt: map['approved_at'],
      approved: map['approved'],
      createdAt: map['created_at'],
      delivered: map['delivered'],
      deliveredAt: map['delivered_at'],
      deliveryApproved: map['delivery_approved'],
      id: map['id'],
      orderStatus: map['order_status'],
      orderId: map['order_id'],
      deliverylocationname: map['delivery_location_name'],
      pickuplocationname: map['pickup_location_name'],
    );
  }
}
