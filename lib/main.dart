import 'package:flutter/material.dart';
import 'package:mirror_wall/controllers/providers/internetcheak_provider.dart';
import 'package:mirror_wall/views/screens/intro_screen.dart';
import 'package:mirror_wall/views/screens/webpage.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => InternetProvider()),
    ],
    builder: (context, _) {
      return MaterialApp(
        theme: ThemeData.light(
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        routes: {
          "web_page": (context) => webpage(),
          "/": (context) => intro_screen(),
        },
      );
    },
  ));
}
