// import 'package:flutter/material.dart';
// import '../services/Product-model.dart'; // Import your Product model
//
// class CartNotifier extends ChangeNotifier {
//   List<Product> _cartItems = [];
//   int productIndex = -1; // Track selected product index
//   List<Product> checkout = [];
//   // var  quantity=0;
//
//   // Method to set the selected product index
//   void setProductIndex(int index) {
//     productIndex = index;
//     notifyListeners();
//   }
//
//   // Get cart items
//   List<Product> get cartItems => _cartItems;
//
//   // Add product to cart
//   void addToCart(Product product) {
//     _cartItems.add(product);
//     notifyListeners();
//   }
//
//   // Remove product from cart
//   void removeFromCart(Product product) {
//     _cartItems.remove(product);
//     notifyListeners();
//   }
//
//   // Increment product quantity
//   void incrementQuantity(Product product) {
//     int index = _cartItems.indexWhere((item) => item.id == product.id);
//     if (index != -1) {
//       _cartItems[index].quantity++;
//       notifyListeners();
//     }
//   }
//
//   // Decrement product quantity
//   void decrementQuantity(Product product) {
//     int index = _cartItems.indexWhere((item) => item.id == product.id);
//     if (index != -1 && _cartItems[index].quantity > 1) {
//       _cartItems[index].quantity--;
//       notifyListeners();
//     } else if (_cartItems[index].quantity == 1) {
//       removeFromCart(product); // Remove the item if the quantity becomes 0
//     }
//   }
//
//   // Get total number of items in cart
//   int getTotalItems() {
//     return _cartItems.fold(0, (sum, item) => sum + item.quantity);
//   }
//
//   // Clear the cart
//   void clearCart() {
//     _cartItems.clear();
//     notifyListeners();
//   }
//
//   // Method to checkout items
//   void checkoutItems() {
//     checkout.addAll(_cartItems);
//     clearCart();
//   }
// }
