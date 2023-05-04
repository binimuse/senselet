class NotificationbypkQuery {
  dynamic getnotification(String id) {
    return """
subscription {
  notifications(order_by: {created_at: desc}, where: {read: {_eq: false}, user_id: {_eq: "$id"}}) {
    body
    id
    created_at
    read
    title
  }
}

    """;
  }
}
