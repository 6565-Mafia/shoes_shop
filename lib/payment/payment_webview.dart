import 'package:shoes_shop/payment/sucessful_payment.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/payment_provider.dart';
import 'failed_payment.dart';
// import 'successful_payment.dart';

class PaymentWebView extends StatefulWidget {
  const PaymentWebView({Key? key}) : super(key: key);

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    final paymentNotifier = Provider.of<PaymentNotifier>(context, listen: false);
    final platformParams = _getPlatformParams();

    _controller = WebViewController.fromPlatformCreationParams(platformParams)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Page resource error: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains("checkout-success")) {
              _navigateToSuccess(paymentNotifier);
              return NavigationDecision.prevent;
            } else if (request.url.contains("cancel")) {
              _navigateToFailure(paymentNotifier);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            final url = change.url;
            if (url != null) {
              if (url.contains("checkout-success")) {
                _navigateToSuccess(paymentNotifier);
              } else if (url.contains("cancel")) {
                _navigateToFailure(paymentNotifier);
              }
              debugPrint('URL change to $url');
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(paymentNotifier.paymentUrl));

    if (_controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (_controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
  }

  PlatformWebViewControllerCreationParams _getPlatformParams() {
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      return WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      return const PlatformWebViewControllerCreationParams();
    }
  }

  void _navigateToSuccess(PaymentNotifier paymentNotifier) {
    paymentNotifier.setPaymentUrl = '';
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Successful()),
    );
  }

  void _navigateToFailure(PaymentNotifier paymentNotifier) {
    paymentNotifier.setPaymentUrl = '';
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Failed()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 20,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
