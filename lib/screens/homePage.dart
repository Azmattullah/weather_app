import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_data_provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final latLongProvider = Provider.of<WeatherDataProvider>(context);
    latLongProvider.getLatLong(context);
    latLongProvider.fetchWeatherReports(latLongProvider.position);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Latitude: ${latLongProvider.position["lat"]}'),
            Text('Longitude: ${latLongProvider.position["long"]}'),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                _buildWeatherInfo('City', latLongProvider.report.name),
                _buildWeatherInfo(
                    'Temperature', '${latLongProvider.report.main.temp} K'),
                _buildWeatherInfo(
                    'Feels Like', '${latLongProvider.report.main.feelsLike} K'),
                _buildWeatherInfo(
                    'Description',
                    latLongProvider.report.weather.isNotEmpty
                        ? latLongProvider.report.weather[0].description
                        : ''),
                _buildWeatherInfo(
                    'Humidity', '${latLongProvider.report.main.humidity} %'),
                _buildWeatherInfo(
                    'Pressure', '${latLongProvider.report.main.pressure} hPa'),
                _buildWeatherInfo(
                    'Wind Speed', '${latLongProvider.report.wind.speed} m/s'),
                _buildWeatherInfo(
                    'Cloudiness', '${latLongProvider.report.clouds.all} %'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(String title, String value) {
    return Container(
      color: Colors.grey,
      margin: EdgeInsets.symmetric(horizontal: 600),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
        children: [
          Text(
            '$title:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }

}
