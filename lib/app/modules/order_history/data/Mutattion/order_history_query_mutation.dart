class OrderHistoryQueryMutation {
//   dynamic getMyOrdersHistory(String userId) {
//     return """
// query MyQuery {
//   orders(where: {created_by_id: {_eq: "$userId"}}, order_by: {id: desc}) {
//     id
//     detail
//     approved_at
//     approved
//     created_at
//     delivered
//     delivered_at
//     delivery_approved
//     order_status
//     order_id
//     pickup_location_name
//     delivery_location_name
//   }
// }

//     """;
//   }

  dynamic getMyOrdersHistorysub(String userId) {
    return """
subscription MyQuery {
  orders(where: {created_by_id: {_eq: "$userId"}}, order_by: {id: desc, created_at: desc}) {
    id
    detail
    approved_at
    approved
    created_at
    delivered
    delivered_at
    delivery_approved
    order_status
    order_id
    pickup_location_name
    delivery_location_name
  }
}

    """;
  }
}
