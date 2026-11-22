import '../../domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.cityName,
    required super.temperatureC,
    required super.windSpeedKmh,
    required super.weatherCode,
    required super.isDay,
  });

  factory WeatherModel.fromOpenMeteoJson({
    required String cityName,
    required Map<String, dynamic> json,
  }) {
    final current = json['current'] as Map<String, dynamic>;
    final isDayRaw = current['is_day'];
    final isDay = isDayRaw is num ? isDayRaw.toInt() == 1 : true;

    return WeatherModel(
      cityName: cityName,
      temperatureC: (current['temperature_2m'] as num).toDouble(),
      windSpeedKmh: (current['wind_speed_10m'] as num).toDouble(),
      weatherCode: (current['weather_code'] as num).toInt(),
      isDay: isDay,
    );
  }
}