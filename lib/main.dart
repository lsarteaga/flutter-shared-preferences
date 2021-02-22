import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:preferencestaller/pages/home_page.dart';
import 'package:preferencestaller/services/content_provider.dart';
import 'package:preferencestaller/utils/preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences().init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ContentProvider>(
      create: (_) => ContentProvider(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  final prefs = new Preferences();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContentProvider>(
        create: (BuildContext context) => ContentProvider(),
        child: Consumer<ContentProvider>(builder: (context, provider, __) {
          provider.initScaleMode(prefs.mode);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Cities Temp',
            home: HomePage(),
          );
        }));
  }
}
