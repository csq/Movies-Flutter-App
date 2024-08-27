import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies/src/pages/movie_detail_page.dart';
import 'package:movies/src/pages/home_page.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  runApp(MainApp());
}

// ignore: must_be_immutable
class MainApp extends StatelessWidget {
  MainApp({super.key});

  AppBarTheme appBarTheme = const AppBarTheme(
    color: Colors.blueAccent,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
    )
  );

  @override
  Widget build(BuildContext context) {
    
    // Set the vertical orientation for default
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return OrientationBuilder(
      builder: (context, orientation) {

        return MaterialApp(
          theme: ThemeData(
            appBarTheme: appBarTheme,
          ),
          debugShowCheckedModeBanner: false,
          title: 'Movies Page',
          initialRoute: '/',
          routes: {
            '/': (BuildContext context) => HomePage(),
            'detail': (BuildContext context) => const MovieDetailPage(),
          },
        );

      }
    );
  }
}
