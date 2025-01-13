import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'dart:convert';

class StoreLocationsScreen extends StatelessWidget {
  const StoreLocationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String htmlContent = '''
      <html>
        <body style="margin:0;">
          <iframe 
            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3826.324044905867!2d107.59014767434795!3d16.459121584278307!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3141a13f462a1445%3A0x1b70ba6cb49fb526!2sHue%20University%20of%20Sciences!5e0!3m2!1sfr!2s!4v1736792274939!5m2!1sfr!2s" 
            width="100%" 
            height="100%" 
            style="border:0;" 
            allowfullscreen="" 
            loading="lazy" 
            referrerpolicy="no-referrer-when-downgrade">
          </iframe>
        </body>
      </html>
    ''';

    final String contentBase64 = base64Encode(const Utf8Encoder().convert(htmlContent));

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Địa chỉ đại lý', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: WebViewWidget(
        controller: WebViewController()
          ..loadRequest(Uri.parse('data:text/html;base64,$contentBase64'))
          ..setJavaScriptMode(JavaScriptMode.unrestricted),
      ),
    );
  }
}