// class CartItem {
//   final String name;
//   final String id;
//   final String price;
//   final int cartQuantity;
//
//   CartItem({
//     required this.name,
//     required this.id,
//     required this.price,
//     required this.cartQuantity,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'id': id,
//       'price': price,
//       'cartQuantity': cartQuantity,
//     };
//   }
// }
//
// class Order {
//   final String userId;
//   final List<CartItem> cartItems;
//   Order({
//     required this.userId,
//     required this.cartItems,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       'userId': userId,
//       'cartItems': cartItems.map((item) => item.toJson()).toList(),
//     };
//   }
// }
class CartItem {
  final String name;
  final String id;
  final String price;
  final int cartQuantity;

  CartItem({
    required this.name,
    required this.id,
    required this.price,
    required this.cartQuantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'price': price,
      'cartQuantity': cartQuantity,
    };
  }

  @override
  String toString() {
    return 'CartItem(name: $name, id: $id, price: $price, cartQuantity: $cartQuantity)';
  }
}

class Order {
  final String userId;
  final List<CartItem> cartItems;

  Order({
    required this.userId,
    required this.cartItems,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'cartItems': cartItems.map((item) => item.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Order(userId: $userId, cartItems: $cartItems)';
  }
}
