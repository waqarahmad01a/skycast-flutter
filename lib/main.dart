import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/weather/data/datasources/weather_remote_datasource.dart';
import 'features/weather/data/repositories/weather_repository_impl.dart';
import 'features/weather/domain/usecases/get_weather_by_city.dart';
import 'features/weather/presentation/cubit/weather_cubit.dart';
import 'features/weather/presentation/screens/weather_home_screen.dart';

void main() {
  final dio = Dio();
  final dataSource = WeatherRemoteDataSourceImpl(dio);
  final repository = WeatherRepositoryImpl(dataSource);
  final getWeatherByCity = GetWeatherByCity(repository);

  runApp(SkyCastApp(getWeatherByCity: getWeatherByCity));
}

class SkyCastApp extends StatelessWidget {
  final GetWeatherByCity getWeatherByCity;

  const SkyCastApp({super.key, required this.getWeatherByCity});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkyCast',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => WeatherCubit(getWeatherByCity),
        child: const WeatherHomeScreen(),
      ),
    );
  }
}