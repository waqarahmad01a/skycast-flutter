import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getWeatherByCity(String cityName);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final Dio dio;

  const WeatherRemoteDataSourceImpl(this.dio);

  @override
  Future<WeatherModel> getWeatherByCity(String cityName) async {
    try {
      // 1. City name -> latitude & longitude
      final geoResponse = await dio.get(
        '${ApiConstants.geocodingBaseUrl}/search',
        queryParameters: {
          'name': cityName,
          'count': 1,
          'language': 'en',
          'format': 'json',
        },
      );

      final results = geoResponse.data['results'] as List<dynamic>?;
      if (results == null || results.isEmpty) {
        throw const ServerException('City not found');
      }

      final firstMatch = results.first as Map<String, dynamic>;
      final resolvedCity = firstMatch['name'] as String? ?? cityName;
      final lat = (firstMatch['latitude'] as num).toDouble();
      final lon = (firstMatch['longitude'] as num).toDouble();

      // 2. Coordinates -> current weather
      final weatherResponse = await dio.get(
        '${ApiConstants.openMeteoBaseUrl}/forecast',
        queryParameters: {
          'latitude': lat,
          'longitude': lon,
          'current': 'temperature_2m,wind_speed_10m,weather_code,is_day',
        },
      );

      return WeatherModel.fromOpenMeteoJson(
        cityName: resolvedCity,
        json: weatherResponse.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw const NetworkException('No internet connection');
      }
      throw ServerException(e.message ?? 'Failed to fetch weather');
    }
  }
}