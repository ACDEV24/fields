import 'package:dio/dio.dart';
import 'package:fields/app/models/weather.dart';

class ReservationWeatherRepository {
  final Dio dio;

  const ReservationWeatherRepository({
    required this.dio,
  });

  Future<Weather> getWeather(String date) async {
    const apiKey = '702cc876c90d4a5bac9202423232602';
    const host = 'https://api.weatherapi.com';
    final url = '$host/v1/future.json?key=$apiKey&q=Colombia&dt=$date';

    final response = await dio.get(url);

    final weather = Weather.fromJson(response.data);

    return weather;
  }
}
