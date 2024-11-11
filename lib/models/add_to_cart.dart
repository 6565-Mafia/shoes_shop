import 'dart:convert';

AddToCart AddToCartFromJson(String str) =>AddToCart.fromJson(json.decode(str));
// .map((x)=>ProfileRes.fromJson(x)));

// String ProfileResToJson(List<Sneakers> data) => json.encode(data.toJson()));

class AddToCart {
  final String cartItem;
  final int quantity;

  AddToCart({
    required this.cartItem,
    required this.quantity,
  });

  factory AddToCart.fromJson(Map<String, dynamic> json) {
    return AddToCart(
      cartItem: json['cartItem'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cartItem': cartItem,
      'quantity': quantity,
    };
  }
}
