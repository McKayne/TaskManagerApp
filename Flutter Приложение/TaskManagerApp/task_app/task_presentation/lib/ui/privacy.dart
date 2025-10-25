import 'package:flutter/material.dart';
import 'package:task_presentation/uicomponents/bg.dart';


import 'package:webview_flutter/webview_flutter.dart';

// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS/macOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// #enddocregion platform_imports

import 'package:task_resources/l10n/app_localizations.dart';

/**
 * Страница с политикой конфиденциальности при регистрации
 */
class PrivacyPolicyPage extends StatefulWidget {

  const PrivacyPolicyPage({super.key});

  @override
  State<StatefulWidget> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicyPage> {

  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = _setupController();
  }

  /**
   * Настройка webview для отображения прайваси
   */
  WebViewController _setupController() {
    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse('https://docs.flutter.dev/ui/adaptive-responsive/capabilities'));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    return controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          AppLocalizations.of(context)!.privacy,
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 24.0,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          /**
           * Полноэкранная картинка в качестве фона на всю страницу
           */
          background(),

          /**
           * Сам контент (вебвью)
           */
          Container(
            height: double.infinity,
            width: double.infinity,
            child: WebViewWidget(controller: _controller),
          ),

        ],
      ),
    );
  }
}