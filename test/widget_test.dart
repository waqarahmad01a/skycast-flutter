import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skycast_flutter/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:skycast_flutter/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:skycast_flutter/features/weather/domain/usecases/get_weather_by_city.dart';
import 'package:skycast_flutter/main.dart';

void main() {
  testWidgets('SkyCast home screen renders search UI', (
    WidgetTester tester,
  ) async {
    final dio = Dio();
    final dataSource = WeatherRemoteDataSourceImpl(dio);
    final repository = WeatherRepositoryImpl(dataSource);
    final getWeatherByCity = GetWeatherByCity(repository);

    await tester.pumpWidget(SkyCastApp(getWeatherByCity: getWeatherByCity));

    expect(find.text('SkyCast'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
  });
}