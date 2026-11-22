import 'package:flutter/material.dart';

class WeatherCodeInfo {
  final String label;
  final IconData icon;

  const WeatherCodeInfo({required this.label, required this.icon});
}

WeatherCodeInfo mapWeatherCode(int code, {bool isDay = true}) {
  if (code == 0) {
    return WeatherCodeInfo(
      label: 'Clear Sky',
      icon: isDay ? Icons.wb_sunny : Icons.nightlight_round,
    );
  }
  if (code == 1 || code == 2) {
    return WeatherCodeInfo(
      label: 'Partly Cloudy',
      icon: isDay ? Icons.cloud_queue : Icons.nights_stay,
    );
  }
  if (code == 3) {
    return const WeatherCodeInfo(
      label: 'Overcast',
      icon: Icons.cloud,
    );
  }
  if (code == 45 || code == 48) {
    return const WeatherCodeInfo(
      label: 'Foggy',
      icon: Icons.foggy,
    );
  }
  if ((code >= 51 && code <= 67) || (code >= 80 && code <= 82)) {
    return const WeatherCodeInfo(
      label: 'Rain',
      icon: Icons.grain,
    );
  }
  if ((code >= 71 && code <= 77) || code == 85 || code == 86) {
    return const WeatherCodeInfo(
      label: 'Snow',
      icon: Icons.ac_unit,
    );
  }
  if (code >= 95) {
    return const WeatherCodeInfo(
      label: 'Thunderstorm',
      icon: Icons.thunderstorm,
    );
  }
  return const WeatherCodeInfo(
    label: 'Unknown',
    icon: Icons.help_outline,
  );
}