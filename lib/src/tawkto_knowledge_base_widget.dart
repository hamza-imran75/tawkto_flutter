import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tawkto_flutter/src/tawkto_visitor.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// [TawkToKnowledgeBaseWidget] this is the widget that will display your knowledge base
class TawkToKnowledgeBaseWidget extends StatefulWidget {
  /// [knowledgeBaseLink] this link can be obtained from Tawk.to dashboard (Knowledge base portion).
  final String? knowledgeBaseLink;

  /// [onLoad] is the callback that will be called when the chat is loaded.
  final Function()? onLoad;

  /// [onLinkTap] is the callback that will be called when the user taps on the link.
  final Function(String url)? onLinkTap;

  /// [loadingWidget] is the widget that will be displayed while the chat is loading.
  final Widget? loadingWidget;

  const TawkToKnowledgeBaseWidget({
    Key? key,
    required this.knowledgeBaseLink,
    this.onLoad,
    this.onLinkTap,
    this.loadingWidget,
  }) : super(key: key);

  @override
  _TawkToKnowledgeBaseWidgetState createState() =>
      _TawkToKnowledgeBaseWidgetState();
}

class _TawkToKnowledgeBaseWidgetState extends State<TawkToKnowledgeBaseWidget> {
  WebViewController? _webViewController;
  bool _isLoading = true;

  /// [runJS] injects the given js code into the webview.
  void runJS(TawkToVisitor visitor) {
    final json = jsonEncode(visitor);
    String javascriptString;

    if (Platform.isIOS) {
      javascriptString = '''
        Tawk_API = Tawk_API || {};
        Tawk_API.setAttributes($json);
      ''';
    } else {
      javascriptString = '''
        Tawk_API = Tawk_API || {};
        Tawk_API.onLoad = function() {
          Tawk_API.setAttributes($json);
        };
      ''';
    }

    _webViewController!.runJavascript(javascriptString);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      WebView(
        initialUrl: widget.knowledgeBaseLink,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          setState(() {
            _webViewController = webViewController;
          });
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url == 'about:blank' || request.url.contains('tawk.to')) {
            return NavigationDecision.navigate;
          }

          if (widget.onLinkTap != null) widget.onLinkTap!(request.url);

          return NavigationDecision.prevent;
        },
        onPageFinished: (_) {
          /// Runs the JS code that will set the visitor attributes, also injects other api's.

          /// Calls the function that will be called when the chat is loaded.
          if (widget.onLoad != null) widget.onLoad!();

          /// To remove the loading sign.
          setState(() => _isLoading = false);
        },
      ),
      _isLoading
          ? widget.loadingWidget ??
              const Center(
                child: CircularProgressIndicator(),
              )
          : Container(),
    ]);
  }
}
