import '../../domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.cityName,
    required super.temperatureC,
    required super.windSpeedKmh,
    required super.weatherCode,
  });

  factory WeatherModel.fromOpenMeteoJson({
    required String cityName,
    required Map<String, dynamic> json,
  }) {
    final current = json['current'] as Map<String, dynamic>;
    return WeatherModel(
      cityName: cityName,
      temperatureC: (current['temperature_2m'] as num).toDouble(),
      windSpeedKmh: (current['wind_speed_10m'] as num).toDouble(),
      weatherCode: (current['weather_code'] as num).toInt(),
    );
  }
}