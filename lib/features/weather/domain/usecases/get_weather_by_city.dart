import '../../../../core/error/failures.dart';
import '../entities/weather_entity.dart';
import '../repositories/weather_repository.dart';

class GetWeatherByCity {
  final WeatherRepository repository;

  const GetWeatherByCity(this.repository);

  Future<(Failure?, WeatherEntity?)> call(String cityName) {
    return repository.getWeatherByCity(cityName);
  }
}