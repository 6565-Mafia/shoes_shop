import 'dart:convert';
//
List<PaidOrders> paidOrdersFromJson(String str) => List<PaidOrders>.from(json.decode(str).map((x) => PaidOrders.fromJson(x)));

String paidOrdersToJson(List<PaidOrders> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class PaidOrders {
  String id;
  String userId;
  ProductId productId;
  int quantity;
  int total;
  String deliveryStatus;
  String paymentStatus;

  PaidOrders({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.total,
    required this.deliveryStatus,
    required this.paymentStatus,
  });

  factory PaidOrders.fromJson(Map<String, dynamic> json) => PaidOrders(
    id: json["id"] ?? "",  // Provide a default value if null
    userId: json["userId"] ?? "",
    productId: ProductId.fromJson(json["productId"] ?? {}),  // Handle null for productId
    quantity: json["quantity"] ?? 0,  // Default to 0 if null
    total: json["total"] ?? 0,
    deliveryStatus: json["delivery_status"] ?? "",
    paymentStatus: json["payment_status"] ?? "",

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "productId": productId.toJson(),
    "quantity": quantity,
    "total": total,
    "deliveryStatus": deliveryStatus,
    "paymentStatus": paymentStatus,
  };
}

class ProductId {
  String id;
  String name;
  String title;
  String price;
  // String imageUrl;
  final List<String> imageUrl;
  ProductId({
    required this.id,
    required this.name,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
    id: json["id"] ?? "",  // Provide a default value if null
    name: json["name"] ?? "",
    title: json["title"] ?? "",
    price: json["price"] ?? "",
    // imageUrl: json["imageUrl"] ?? "",
    imageUrl: json["imageUrl"] != null ? List<String>.from(json["imageUrl"]) : [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "title": title,
    "price": price,
    // "imageUrl": imageUrl,
    "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
  };
}
