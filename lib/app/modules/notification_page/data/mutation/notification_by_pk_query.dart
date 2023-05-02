class NotificationbypkQuery {
  dynamic getnotification(int id) {
    return """
        subscription {
  users_by_pk(id: $id) {
    notifications( order_by: {created_at: desc},where: {read: {_eq: false}}) {
      body
      id
   
      created_at
      read
      title
    }
  }
        }
    """;
  }
}
