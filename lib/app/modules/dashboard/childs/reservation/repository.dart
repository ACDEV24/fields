import 'package:dio/dio.dart';
import 'package:fields/app/models/weather.dart';

class ReservationWeatherRepository {
  final Dio dio;

  const ReservationWeatherRepository({
    required this.dio,
  });

  Future<Weather> getWeather(String date) async {
    const host = 'https://api.open-meteo.com';
    const latLong = 'latitude=4.61&longitude=-74.08';
    const hourly = 'temperature_2m,precipitation_probability';
    final startAndEnd = 'start_date=$date&end_date=$date';
    final url = '$host/v1/forecast?$latLong&hourly=$hourly&$startAndEnd';

    final response = await dio.get(url);

    final weather = Weather.fromJson(response.data);

    return weather;
  }
}
