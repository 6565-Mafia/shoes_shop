
import 'dart:convert';
List<GetCart> getCartFromJson(String str) =>
    List<GetCart>.from(json.decode(str).map((x) => GetCart.fromJson(x)));


class GetCart {
  final List<Product> products;

  GetCart({
    required this.products,
  });


  factory GetCart.fromJson(Map<String, dynamic> json) => GetCart(
    products: List<Product>.from(
        json["products"].map((x) => Product.fromJson(x))),
  );
}
class Product {
  final String id;
  final int quantity;
  final ProductItem cartItem;

  Product({
    required this.id,
    required this.quantity,
    required this.cartItem,
  });


  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
    quantity: json["quantity"],
    cartItem: ProductItem.fromJson(json["cartItem"]),
  );
}


class ProductItem {
  final String id;
  final String name;
  final String category;
  final List<String> imageUrl;
  final String price;

  ProductItem({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
  });


  factory ProductItem.fromJson(Map<String, dynamic> json) => ProductItem(
    id: json["_id"],
    name: json["name"],
    category: json["category"],
    imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
    price: json["price"],
  );


  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "category": category,
    "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
    "price": price,
  };
}
