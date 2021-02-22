import 'dart:convert';

class Cities {
  List<City> items = new List();

  Cities();

  Cities.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final pais = new City.fromJson(item);
      items.add(pais);
    }
  }
}

City cityFromJson(String str) => City.fromJson(json.decode(str));

String cityToJson(City data) => json.encode(data.toJson());

class City {
  City({
    this.values,
    this.name,
    this.cod,
  });

  Values values;
  String name;
  int cod;

  factory City.fromJson(Map<String, dynamic> json) => City(
        values: Values.fromJson(json["values"]),
        name: json["name"],
        cod: json["cod"],
      );

  Map<String, dynamic> toJson() => {
        "values": values.toJson(),
        "name": name,
        "cod": cod,
      };
}

class Values {
  Values({
    this.temp,
    this.tempMin,
    this.tempMax,
  });

  double temp;
  double tempMin;
  double tempMax;

  factory Values.fromJson(Map<String, dynamic> json) => Values(
        temp: json["temp"].toDouble(),
        tempMin: json["temp_min"].toDouble(),
        tempMax: json["temp_max"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "temp_min": tempMin,
        "temp_max": tempMax,
      };
}
