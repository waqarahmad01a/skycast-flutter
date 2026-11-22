import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String cityName;
  final double temperatureC;
  final double windSpeedKmh;
  final int weatherCode;
  final bool isDay;

  const WeatherEntity({
    required this.cityName,
    required this.temperatureC,
    required this.windSpeedKmh,
    required this.weatherCode,
    required this.isDay,
  });

  @override
  List<Object?> get props => [
        cityName,
        temperatureC,
        windSpeedKmh,
        weatherCode,
        isDay,
      ];
}