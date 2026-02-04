import 'package:flutter/material.dart';

import 'screens/whether_screen.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Arial',
          textTheme: TextTheme(
              bodyLarge: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)
          )
      ),
      home: WhetherScreen(),
    );
  }
}
