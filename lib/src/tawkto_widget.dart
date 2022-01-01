import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tawkto_flutter/src/tawkto_visitor.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// [TawkToWidget] is the main widget that will be used to display the chat.
class TawkToWidget extends StatefulWidget {
  /// [directChatLink] this link can be obtained from Tawk.to dashboard.
  final String? directChatLink;

  /// [visitor] is the [TawkToVisitor] object that will be used during communication.
  final TawkToVisitor? visitor;

  /// [onLoad] is the callback that will be called when the chat is loaded.
  final Function()? onLoad;

  /// [onLinkTap] is the callback that will be called when the user taps on the link.
  final Function(String url)? onLinkTap;

  /// [onChatMessageAgent] is the callback that will be called when a message is received from the agent.
  final Function(String message)? onChatMessageAgent;

  /// [loadingWidget] is the widget that will be displayed while the chat is loading.
  final Widget? loadingWidget;

  const TawkToWidget({
    Key? key,
    required this.directChatLink,
    this.visitor,
    this.onLoad,
    this.onLinkTap,
    this.onChatMessageAgent,
    this.loadingWidget,
  }) : super(key: key);

  @override
  _TawkToWidgetState createState() => _TawkToWidgetState();
}

class _TawkToWidgetState extends State<TawkToWidget> {
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

    javascriptString = '''
      window.Tawk_API = window.Tawk_API || {};
      window.Tawk_API.onChatMessageAgent = function(message){
      window.AGENT_MSG_CHANNEL.postMessage(message);
        console.log(message);
}; ''';

    _webViewController!.runJavascript(javascriptString);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      WebView(
        initialUrl: widget.directChatLink,
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: {
          /// We use javascript channels to communicate with the webview.
          /// This channel handles the messages received from the agent.
          JavascriptChannel(

              /// This channel name must be the same as the one used in the javascript code. It can be anything.
              name: 'AGENT_MSG_CHANNEL',
              onMessageReceived: (data) {
                widget.onChatMessageAgent!(data.message);
              }),
        },
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
          if (widget.visitor != null) runJS(widget.visitor!);

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
