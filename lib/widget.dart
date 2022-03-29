import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends Container {
  MyWebView( String url, { Key? key, required double width, required double height } ) : super(
      key: key,
      width: width,
      height: height,
      child: WebView(
        onWebViewCreated: ( WebViewController webView ){
          webView.loadUrl( url );
        },
        javascriptMode: JavascriptMode.unrestricted,
      )
  );
}

class MyWebViewFromAsset extends Container {
  MyWebViewFromAsset( String file, { Key? key, required double width, required double height } ) : super(
      key: key,
      width: width,
      height: height,
      child: WebView(
        onWebViewCreated: ( WebViewController webView ) async {
          await MyWebViewFromAsset.loadHtmlFromAsset( webView, file );
        },
        javascriptMode: JavascriptMode.unrestricted,
      )
  );

  static Future loadHtmlFromAsset( WebViewController webView, String file ) async {
    String htmlData = await rootBundle.loadString( file );
    webView.loadUrl( Uri.dataFromString(
        htmlData,
        mimeType: 'text/html',
        encoding: Encoding.getByName( 'utf-8' )
    ).toString() );
  }
}
