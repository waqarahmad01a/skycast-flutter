import '../../../../core/error/failures.dart';
import '../entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<(Failure?, WeatherEntity?)> getWeatherByCity(String cityName);
}