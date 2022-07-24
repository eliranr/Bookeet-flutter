import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart';
import 'package:native_notify/native_notify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';



void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  NativeNotify.initialize(362, 'B5HDM5xrdc0FjoWfbgbuiM', 'AAAAEFG_mwY:APA91bF8u2LC-9SKDUs2P5hoH4zNMEdIST81RMmyMLB2NUaEV_vuFLCMYZ0Oi5AGrN6-rSFSNv7qTYTt8gUJXyIHcp_FOnZCipw12hPOWe4kJaQgs2U1vniTACw2m2FxvMcHHAe-0_QK', 'resource://drawable/notification_icon');

  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
    title: 'Bookeet',
  ));
}





class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FlutterStatusbarcolor.setStatusBarColor(Color(0xff3f9db2));

    //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //statusBarColor: Color(0xff3f9db2),
      //statusBarBrightness: Brightness.dark,
      //statusBarIconBrightness: Brightness.light,
    //));
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: WebView(
            zoomEnabled: false,
            onWebResourceError: (WebResourceError webviewerrr) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => boten()));
            },
            javascriptChannels: [
              JavascriptChannel(name: 'REG_FLUT', onMessageReceived: (msg) {
                NativeNotify.registerIndieID(msg.message);
                print('yeahhh')
;              })
            ].toSet(),
            initialUrl: 'https://www.bookeet.co.il/login',
            javascriptMode: JavascriptMode.unrestricted,
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith("https://www.bookeet.co.il")) {
                return NavigationDecision.navigate;
              } else {
                _launchURL(request.url);
                return NavigationDecision.prevent;
              }
            },
            onPageFinished: (String url) async {
              await Future.delayed(Duration(milliseconds: 1700));
              FlutterNativeSplash.remove();
            },
          ),
        ),
      ),
    );
  }
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}


class boten extends StatelessWidget {
  const boten({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('ללא גישה לאינטרנט', style: TextStyle(fontSize: 25),),
                    Text('אנא בדוק את חיבור הרשת שלך', style: TextStyle(fontSize: 25),)
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}




