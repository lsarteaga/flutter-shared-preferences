import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:preferencestaller/models/models.dart';
import 'package:preferencestaller/pages/settings_page.dart';
import 'package:preferencestaller/utils/preferences.dart';
import 'package:preferencestaller/utils/utils.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:flutter/services.dart' show rootBundle;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Cities _list;
  Preferences prefs = new Preferences();
  int flag = 0;
  bool initialPref;
  List<dynamic> data;
  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/data/cities.json');
    setState(() => data = json.decode(jsonText));
    _list = Cities.fromJsonList(data);
    print(jsonText);
  }

  @override
  void initState() {
    this.loadJsonData();
    super.initState();
    print('valor de las prefs');
    print(prefs.mode);
    initialPref = (prefs.mode == true) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            PopupMenuButton<MenuItem>(
              onSelected: (value) {
                if (value.key == "config") {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingsPage()));
                }
              },
              itemBuilder: (BuildContext context) {
                return mainActions.map((MenuItem option) {
                  return PopupMenuItem<MenuItem>(
                      value: option,
                      child: Row(
                        children: [
                          Icon(option.icon,
                              color: Theme.of(context).primaryColor),
                          SizedBox(width: 14.0),
                          Text(option.title)
                        ],
                      ));
                }).toList();
              },
            ),
          ],
          title: Text("Temperaturas",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .apply(color: Colors.white))),
      body: _list == null
          ? Container(child: Center(child: Text("Cargando datos")))
          : ListView(
              children: _list.items.map((e) {
              return _getItem(e);
            }).toList()),
    );
  }

  // C -> F
  double _changeValue(double temp) {
    double aux = temp * (9 / 5) + 32;
    return aux;
  }

  // F -> C
  double _changeValue2(double temp) {
    double aux = (temp - 32) * (5 / 9);
    return aux;
  }

  Widget _getItem(City city) {
    /* cuando inicia la app tiene valores por defecto
    dependiendo la opcion de las shared preferences 
     caso 1 
     convertir de celcius a farenheit teniendo celcius como
     valor guardado en prefs

     caso 2
     convertir de farenherit a celsius teniendo farenheit como
     valor guardado en prefs */

    /* al iniciar la app solo debe mostrar los valores guardados segun prefs
     luego, cuando se cambio el checkbox, debe comenzar a realizar las
     conversiones correspondientes */

    /* si flag es 0 significa la carga inicial de la app, se muestran los valores de json
    si flag es 1 significa que se cambio el valor de prefs, por lo que transforma */

    double temp = city.values.temp;
    double temp2 = city.values.tempMax;
    double temp3 = city.values.tempMin;
    if (prefs.mode != initialPref) {
      flag = 1;
    }

    if (flag == 0 && prefs.mode == true) {
      city.values.temp = _changeValue2(_changeValue(temp));
      city.values.tempMax = _changeValue2(_changeValue(temp2));
      city.values.tempMin = _changeValue2(_changeValue(temp3));
    }
    // valor inicial en celcius transformado a farenheit
    if (flag == 0 && prefs.mode == false) {
      city.values.temp = _changeValue(temp);
      city.values.tempMax = _changeValue(temp2);
      city.values.tempMin = _changeValue(temp3);
    }

    if (prefs.mode == false && flag == 1) {
      city.values.temp = _changeValue(temp);
      city.values.tempMax = _changeValue(temp2);
      city.values.tempMin = _changeValue(temp3);
    }
    if (prefs.mode == true && flag == 1) {
      city.values.temp = _changeValue2(temp);
      city.values.tempMax = _changeValue2(temp2);
      city.values.tempMin = _changeValue2(temp3);
    }

    return Card(
      elevation: 2.0,
      shadowColor: Theme.of(context).primaryColorDark,
      child: ListTile(
          leading: Icon(WeatherIcons.thermometer),
          trailing: Text(format(city.values.temp)),
          //trailing: Text(format(temp)),
          title: Text(city.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Text("Mínima: " + format(temp2)),
              //Text("Máxima: " + format(temp3)),
              Text("Mínima: " + format(city.values.tempMin)),
              Text("Máxima: " + format(city.values.tempMax)),
            ],
          )),
    );
  }
}
