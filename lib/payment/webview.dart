// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../controller/payment_provider.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// class WebView extends StatefulWidget {
//   const WebView({super.key});

//   @override
//   State<WebView> createState() => _WebViewState();
// }

// class _WebViewState extends State<WebView> {
//   final controller =WebViewController();

// //   @override
// //   // void initState() {
// //   //   super.initState();
// //
// //   // Use the WebViewController through the WebView widget itself
// //   // _controller = WebViewController()
// //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
// //   ..setNavigationDelegate(
// //   NavigationDelegate(
// //   onPageStarted: (String url) {},
// //   onPageFinished: (String url) {},
// //   onWebResourceError: (WebResourceError error) {
// //   debugPrint('''Error: ${error.description}, Code: ${error.errorCode}''');
// //   },
// //   onNavigationRequest: (NavigationRequest request) {
// //   debugPrint('Navigating to: ${request.url}');
// //   return NavigationDecision.navigate;
// //   },
// //   onUrlChange: (UrlChange change) {
// //   var paymentNotifier = Provider.of<PaymentNotifier>(context, listen: false);
// //   if (change.url != null) {
// //   if (change.url!.contains("checkout-success")) {
// //   paymentNotifier.setPaymentUrl = '';
// //   Navigator.push(
// //   context,
// //   MaterialPageRoute(builder: (context) => Successful()),
// //   );
// //   } else if (change.url!.contains("cancel")) {
// //   paymentNotifier.setPaymentUrl = '';
// //   Navigator.push(
// //   context,
// //   MaterialPageRoute(builder: (context) => PaymentFailed()),
// //   );
// //   }
// //   }
// //   },
// //   ),
// //   )
// //   ..addJavaScriptChannel(
// //   'Toaster',
// //   onMessageReceived: (JavaScriptMessage message) {
// //   ScaffoldMessenger.of(context).showSnackBar(
// //   SnackBar(content: Text(message.message)),
// //   );
// //   },
// //   );
// // }

// @override
// Widget build(BuildContext context) {
//   var paymentNotifier = Provider.of<PaymentNotifier>(context);

//   return Scaffold(
//     backgroundColor: Colors.white,
//     appBar: AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       toolbarHeight: 20,
//     ),
//     // body:,
//     // WebViewWidget(controller: _controller)
//     //   ..loadRequest(Uri.parse(paymentNotifier.paymentUrl)),
//   );
// }
// }
