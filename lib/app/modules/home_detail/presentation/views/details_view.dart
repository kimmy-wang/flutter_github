import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/detail_controller.dart';

class DetailsView extends GetView<DetailController> {
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
        elevation: 0,
        centerTitle: true,
        actions: [],
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
}
