import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_remote_datasource.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  const WeatherRepositoryImpl(this.remoteDataSource);

  @override
  Future<(Failure?, WeatherEntity?)> getWeatherByCity(String cityName) async {
    try {
      final weather = await remoteDataSource.getWeatherByCity(cityName);
      return (null, weather);
    } on NetworkException catch (e) {
      return (NetworkFailure(e.message), null);
    } on ServerException catch (e) {
      return (ServerFailure(e.message), null);
    } catch (_) {
      return (const ServerFailure('Unexpected error occurred'), null);
    }
  }
}