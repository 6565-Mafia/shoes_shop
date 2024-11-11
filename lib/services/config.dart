class Config {
//  static const apiUrl= "localhost:3005";
 static const apiUrl = 'http://192.168.43.144:3005'; // Replace with your local IP address
  // static const apiUrl ='http://localhost:3005'; // Replace with your local IP address
  static const paymentBaseUrl = "serverpayment-production-4797.up.railway.app";
  static const String loginUrl = "/api/login";
  static const String paymentUrl = "/stripe/create-checkout-session";
  static const String signupUrl = "/api/register";
  static const String getCartUrl = "/api/cart/find";
  static const String addCartUrl = "/api/cart";
  static const String getUserUrl = "/api/users/";
  static const String sneakers = "/api/products";
  static const String orders = "/api/orders";
  static const String search = "/api/products/search/";
  static const String profile = "/api/product/search/";
}
