import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_weather_by_city.dart';
import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final GetWeatherByCity getWeatherByCity;

  WeatherCubit(this.getWeatherByCity) : super(const WeatherInitial());

  Future<void> fetchWeather(String cityName) async {
    final trimmed = cityName.trim();
    if (trimmed.isEmpty) {
      emit(const WeatherError('Please enter a city name'));
      return;
    }

    emit(const WeatherLoading());
    final (failure, weather) = await getWeatherByCity(trimmed);

    if (failure != null) {
      emit(WeatherError(failure.message));
    } else if (weather != null) {
      emit(WeatherLoaded(weather));
    } else {
      emit(const WeatherError('Unable to load weather'));
    }
  }
}