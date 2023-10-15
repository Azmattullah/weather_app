class Temperatures {
  Coord coord;
  List<Weather> weather;
  String base;
  Main main;
  int visibility;
  Wind wind;
  Clouds clouds;
  int dt;
  Sys sys;
  int timezone;
  int id;
  String name;
  int cod;

  Temperatures({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  // Named constructor to create an empty instance
  Temperatures.empty()
      : coord = Coord(lon: 0.0, lat: 0.0),
        weather = [],
        base = '',
        main = Main(temp: 0.0, feelsLike: 0.0, tempMin: 0.0, tempMax: 0.0, pressure: 0, humidity: 0),
        visibility = 0,
        wind = Wind(speed: 0.0, deg: 0),
        clouds = Clouds(all: 0),
        dt = 0,
        sys = Sys(type: 0, id: 0, country: '', sunrise: 0, sunset: 0),
        timezone = 0,
        id = 0,
        name = '',
        cod = 0;
}

class Clouds {
  int all;

  Clouds({
    required this.all,
  });

  // Named constructor to create an empty instance
  Clouds.empty() : all = 0;
}

class Coord {
  double lon;
  double lat;

  Coord({
    required this.lon,
    required this.lat,
  });

  // Named constructor to create an empty instance
  Coord.empty() : lon = 0.0, lat = 0.0;
}

class Main {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  // Named constructor to create an empty instance
  Main.empty()
      : temp = 0.0,
        feelsLike = 0.0,
        tempMin = 0.0,
        tempMax = 0.0,
        pressure = 0,
        humidity = 0;
}

class Sys {
  int type;
  int id;
  String country;
  int sunrise;
  int sunset;

  Sys({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  // Named constructor to create an empty instance
  Sys.empty()
      : type = 0,
        id = 0,
        country = '',
        sunrise = 0,
        sunset = 0;
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  // Named constructor to create an empty instance
  Weather.empty()
      : id = 0,
        main = '',
        description = '',
        icon = '';
}

class Wind {
  double speed;
  int deg;

  Wind({
    required this.speed,
    required this.deg,
  });

  // Named constructor to create an empty instance
  Wind.empty() : speed = 0.0, deg = 0;
}
