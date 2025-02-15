import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zeppe_learn/pages/homePage.dart';
import 'package:device_preview/device_preview.dart';
import 'package:zeppe_learn/pages/quizzVideoPage.dart';
import 'package:zeppe_learn/widgets/player/VideoDemo.dart';

void main() {
  runApp(
    const MyApp()
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) => ,
    // )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      // initialRoute: '/quizzVideo',
      // routes: {
      //   '/home': (context) => Homepage(),
      //   '/quizzVideo': (context) => QuizzesPage() 
      // },
      home: Homepage(),
    );
  }
}



