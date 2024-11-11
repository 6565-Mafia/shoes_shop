import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart ' as http;
import '../models/add_to_cart.dart';
import '../models/paidorder.dart';
import 'Product-model.dart';
import 'config.dart';

class CartHelper{
  static var client=http.Client();
Future<String?> _getUserToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

Map<String, String> _createHeaders(String? token) {
  return {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
}

Future<bool> addToCart(AddToCart model) async {
  String? userToken = await _getUserToken();
  if (userToken == null) throw Exception("No token found. Please log in again.");

  final url = Uri.parse('http://192.168.43.144:3005/api/cart');
  try {
    var response = await client.post(
      url,
      headers: _createHeaders(userToken),
      body: jsonEncode(model.toJson()),
    );

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    return response.statusCode == 200;
  } catch (e) {
    print("Exception: $e");
    return false;
  }
}


   Future<List<Product>> getCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('token');

    if (userToken == null) {
      throw Exception("User token is null. Cannot retrieve cart data.");
    }

    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer $userToken',
    };

    // final url = Uri.parse('http://localhost:3005/api/cart/find');
    final url = Uri.parse('http://192.168.43.144:3005/api/cart/find');
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      print("Response body: ${response.body}");

      try {

        if (response.body.isEmpty) {
          throw Exception("Empty response body");
        }

        // Parse the JSON data and handle any errors
        var jsonData = json.decode(response.body);
        print("Parsed JSON Data: $jsonData"); // Debug print the parsed JSON

        if (jsonData == null) {
          throw Exception("Parsed JSON data is null");
        }

        // Convert the JSON data to a GetCart object
        List<Product> cart = GetCart.fromJson(jsonData).products;
        print("Parsed Cart Products: $cart"); // Debug print cart products

        return cart;
      } catch (e) {
        print("Error parsing cart data: $e");
        throw Exception("Failed to parse cart data.");
      }
    } else {
      throw Exception("Failed to get the cart. Status code: ${response.statusCode}");
    }
  }

  Future<bool> deleteItem(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('token');

    // Return early if the token is null to avoid sending a request
    if (userToken == null) {
      throw Exception("User token is null. Cannot delete cart item.");
    }

    // Set request headers with authorization token
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken'
    };

    // Construct the URL for deleting the item with the given ID
    // final url = Uri.parse('http://localhost:3005/api/cart/$id');
    final url = Uri.parse('http://192.168.43.144:3005/api/cart/$id');

    print("Deleting cart item with ID: $id at URL: $url"); // Debug print

    try {
      // Send the delete request to the server
      var response = await client.delete(url, headers: requestHeaders);

      // Check the response status code to determine success or failure
      if (response.statusCode == 200) {
        print("Item deleted successfully: ${response.body}"); // Debug print
        return true;
      } else {
        print("Failed to delete item. Status code: ${response.statusCode}, Response: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error occurred while deleting item: $e");
      return false;
    }
  }
  Future<List<PaidOrders>> getOrders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('token');

    if (userToken == null) {
      throw Exception("User token is null. Cannot retrieve cart data.");
    }

    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer $userToken',
    };

    // final url = Uri.parse('http://localhost:3005/api/orders');
    final url = Uri.parse('http://192.168.43.144:3005/api/orders');
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var products=paidOrdersFromJson(response.body);
      print('Received orders: $products');
      print('Received orders: ${jsonEncode(products)}');
      return products;

    } else {
      throw Exception("Failed to get orders. Status code: ${response.statusCode}");
    }
  }

}

