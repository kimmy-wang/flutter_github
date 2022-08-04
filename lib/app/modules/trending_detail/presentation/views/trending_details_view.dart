import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/trending_detail_controller.dart';


class TrendingDetailsView extends GetView<TrendingDetailController> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.repoName),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          InAppWebView(
            key: webViewKey,
            // contextMenu: contextMenu,
            // initialUrlRequest:
            //     URLRequest(url: Uri.parse("https://github.com/flutter")),
            initialFile: "assets/www/index.html",
            initialUserScripts: UnmodifiableListView<UserScript>([]),
            initialOptions: options,
            pullToRefreshController: controller.pullToRefreshController,
            onWebViewCreated: (_controller) {
              controller.webViewController = _controller;
              registerHandler();
            },
            onLoadStart: (controller, url) {
              // setState(() {
              //   this.url = url.toString();
              //   urlController.text = this.url;
              // });
            },
            androidOnPermissionRequest: (controller, origin, resources) async {
              return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT);
            },
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              var uri = navigationAction.request.url!;

              if (![
                "http",
                "https",
                "file",
                "chrome",
                "data",
                "javascript",
                "about"
              ].contains(uri.scheme)) {
                if (await canLaunchUrl(uri)) {
                  // Launch the App
                  await launchUrl(
                    uri,
                  );
                  // and cancel the request
                  return NavigationActionPolicy.CANCEL;
                }
              }

              return NavigationActionPolicy.ALLOW;
            },
            onLoadStop: (_controller, url) async {
              controller.pullToRefreshController.endRefreshing();
              registerMessageChannel();
              // setState(() {
              //   this.url = url.toString();
              //   urlController.text = this.url;
              // });
            },
            onLoadError: (_controller, url, code, message) {
              controller.pullToRefreshController.endRefreshing();
            },
            onProgressChanged: (_controller, progress) {
              if (progress == 100) {
                controller.pullToRefreshController.endRefreshing();
              }

              controller.updateProgress(progress / 100);

              // setState(() {
              //   this.progress = progress / 100;
              //   urlController.text = this.url;
              // });
            },
            onConsoleMessage: (controller, consoleMessage) {
              print(consoleMessage);
            },
          ),
          Obx(() => controller.progress.value < 1.0 ? Center(child: CircularProgressIndicator(value: controller.progress.value,),) : Container())
        ],
      ),
    );
  }

  void registerHandler() {
    controller.webViewController?.addJavaScriptHandler(handlerName: 'receiveHandler', callback: (args) {
      // print arguments coming from the JavaScript side!
      print(args);

      // return data to the JavaScript side!
      return {
        'bar': 'bar_value', 'baz': 'baz_value'
      };
    });
  }

  Future<void> registerMessageChannel() async {
    if (!Platform.isAndroid || await AndroidWebViewFeature.isFeatureSupported(AndroidWebViewFeature.CREATE_WEB_MESSAGE_CHANNEL)) {
      // wait until the page is loaded, and then create the Web Message Channel
      var webMessageChannel = await controller.webViewController?.createWebMessageChannel();
      var port1 = webMessageChannel!.port1;
      var port2 = webMessageChannel.port2;

      // set the web message callback for the port1
      await port1.setWebMessageCallback((message) async {
        print("Message coming from the JavaScript side: $message");
        // when it receives a message from the JavaScript side, respond back with another message.
        await port1.postMessage(WebMessage(data: message! + " and back"));
      });

      // transfer port2 to the webpage to initialize the communication
      await controller.webViewController?.postWebMessage(message: WebMessage(data: controller.repoName, ports: [port2]), targetOrigin: Uri.parse("*"));
    }
  }
}
