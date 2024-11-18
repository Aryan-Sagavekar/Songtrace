import "package:flutter/material.dart";
import "package:songtrace/helpers/STColors.dart";
import "package:songtrace/navigation/tabbar.dart";
import "package:songtrace/views/login_view.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          brightness: Brightness.dark,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white10,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(
              fontSize: 12,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 12,
            ),
            selectedItemColor: STColors.brightOrange,
            unselectedItemColor: Colors.white38,
          )),
      home: LoginPage(),
    );
  }
}
