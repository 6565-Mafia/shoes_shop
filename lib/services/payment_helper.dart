import 'dart:convert';

import 'package:http/http.dart ' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/order_model.dart';
import 'config.dart';
class PaymentHelper {
  static var client=http.Client();
  Future<String> payment(Order model) async {
    // Set request headers with authorization token
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    // Construct the URL for deleting the item with the given ID
    // final url = Uri.https(Config.paymentBaseUrl,Config.paymentUrl);
    // var url = Uri.parse('serverpayment-production-4797.up.railway.app/stripe/create-checkout-session');
    // Uri url = Uri.parse("https://serverpayment-production-4797.up.railway.app/stripe/create-checkout-session");
    Uri url = Uri.https('serverpayment-production-4797.up.railway.app', '/stripe/create-checkout-session');

    try {
      // Send the delete request to the server
      var response = await client.post(url, headers: requestHeaders,body: jsonEncode(model.toJson()));
      print("Item added: ${response.body}");
      // Check the response status code to determine success or failure
      if (response.statusCode == 200) {
        var payment =jsonDecode(response.body);
        print("Item proceed successfully: ${response.body}"); // Debug print
        return payment["url"];
      } else {
        print("Failed to proceed item. Status code: ${response.statusCode}, Response: ${response.body}");
        return "failed";
      }
    } catch (e) {
      print("Error occurred while proceed item: $e");
      return e.toString();
    }
  }
}