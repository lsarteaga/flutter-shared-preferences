import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:preferencestaller/services/content_provider.dart';
import 'package:preferencestaller/utils/preferences.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final prefs = new Preferences();
    final _contentProvider = Provider.of<ContentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text("Celsius"),
            leading: Checkbox(
                value: prefs.mode,
                onChanged: (value) {
                  prefs.mode = value;
                  _contentProvider.scaleMode = prefs.mode;
                  if (prefs.mode) {
                    print('escala celsius');
                  } else {
                    print('escala farenheit');
                  }
                  setState(() {});
                }),
          )
        ],
      ),
    );
  }
}
