class OrderHistoryQueryMutation {
  dynamic getMyOrdersHistory(int userId) {
    return """
      query 
         {
  users_by_pk(id: $userId) {
  orders(order_by: {id: desc}) {
      id
      created_at
      delivery_fee
      status
      other_fees
      tax
      order_total
      total
          place
      {
        id
        name
        address
        }
      order_items {
        created_at
        id
        quantity
        variant {
          id
          price
          product {
         products_images
            {
              image
            }
            id
            name
          }
        }
      }
    }
  }
      }
    """;
  }

  dynamic getMyOrdersHistorysub(int userId) {
    return """
      subscription 
         {
  users_by_pk(id: $userId) {
    orders(order_by: {id: desc}) {
      id
      created_at
      delivery_fee
      status
      other_fees
      order_total
      total
      order_items {
        created_at
        id
        quantity
        variant {
          id
          price
          product {
  products_images
            {
              image
            }
            id
            name
          }
        }
      }
    }
  }
      }
    """;
  }
}
