import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String cityName;
  final double temperatureC;
  final double windSpeedKmh;
  final int weatherCode;

  const WeatherEntity({
    required this.cityName,
    required this.temperatureC,
    required this.windSpeedKmh,
    required this.weatherCode,
  });

  @override
  List<Object?> get props => [cityName, temperatureC, windSpeedKmh, weatherCode];
}