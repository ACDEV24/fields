class Weather {
  final double latitude;
  final double longitude;
  final double generationtimeMs;
  final num utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation;
  final num elevation;
  final HourlyUnits hourlyUnits;
  final Hourly hourly;

  const Weather({
    required this.latitude,
    required this.longitude,
    required this.generationtimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.hourlyUnits,
    required this.hourly,
  });

  Weather copyWith({
    double? latitude,
    double? longitude,
    double? generationtimeMs,
    num? utcOffsetSeconds,
    String? timezone,
    String? timezoneAbbreviation,
    num? elevation,
    HourlyUnits? hourlyUnits,
    Hourly? hourly,
  }) {
    return Weather(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      generationtimeMs: generationtimeMs ?? this.generationtimeMs,
      utcOffsetSeconds: utcOffsetSeconds ?? this.utcOffsetSeconds,
      timezone: timezone ?? this.timezone,
      timezoneAbbreviation: timezoneAbbreviation ?? this.timezoneAbbreviation,
      elevation: elevation ?? this.elevation,
      hourlyUnits: hourlyUnits ?? this.hourlyUnits,
      hourly: hourly ?? this.hourly,
    );
  }

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
      generationtimeMs: json['generationtime_ms']?.toDouble() ?? 0.0,
      utcOffsetSeconds: json['utc_offset_seconds'] ?? 0,
      timezone: json['timezone'] ?? '',
      timezoneAbbreviation: json['timezone_abbreviation'] ?? '',
      elevation: json['elevation'] ?? 0,
      hourlyUnits: HourlyUnits.fromJson(json['hourly_units'] ?? {}),
      hourly: Hourly.fromJson(json['hourly'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'generationtime_ms': generationtimeMs,
      'utc_offset_seconds': utcOffsetSeconds,
      'timezone': timezone,
      'timezone_abbreviation': timezoneAbbreviation,
      'elevation': elevation,
      'hourly_units': hourlyUnits.toJson(),
      'hourly': hourly.toJson(),
    };
  }
}

class Hourly {
  final List<DateTime?> time;
  final List<double?> temperature2M;
  final List<num?> precipitationProbability;

  const Hourly({
    this.time = const [],
    this.temperature2M = const [],
    this.precipitationProbability = const [],
  });

  Hourly copyWith({
    List<DateTime>? time,
    List<double>? temperature2M,
    List<num>? precipitationProbability,
  }) {
    return Hourly(
      time: time ?? this.time,
      temperature2M: temperature2M ?? this.temperature2M,
      precipitationProbability:
          precipitationProbability ?? this.precipitationProbability,
    );
  }

  factory Hourly.fromJson(Map<String, dynamic> json) {
    return Hourly(
      time: List<DateTime?>.from(
        (json['time'] ?? []).map(
          (x) => DateTime.tryParse(x),
        ),
      ),
      temperature2M: List<double?>.from(
        (json['temperature_2m'] ?? []).map(
          (x) => x?.toDouble() ?? 0.0,
        ),
      ),
      precipitationProbability: List<num?>.from(
        (json['precipitation_probability'] ?? []).map(
          (x) => x ?? 0,
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': List<dynamic>.from(time.map((x) => x)),
      'temperature_2m': List<dynamic>.from(temperature2M.map((x) => x)),
      'precipitation_probability':
          List<dynamic>.from(precipitationProbability.map((x) => x)),
    };
  }
}

class HourlyUnits {
  final String time;
  final String temperature2M;
  final String precipitationProbability;
  final String precipitation;

  const HourlyUnits({
    required this.time,
    required this.temperature2M,
    required this.precipitationProbability,
    required this.precipitation,
  });

  HourlyUnits copyWith({
    String? time,
    String? temperature2M,
    String? precipitationProbability,
    String? precipitation,
  }) {
    return HourlyUnits(
      time: time ?? this.time,
      temperature2M: temperature2M ?? this.temperature2M,
      precipitationProbability:
          precipitationProbability ?? this.precipitationProbability,
      precipitation: precipitation ?? this.precipitation,
    );
  }

  factory HourlyUnits.fromJson(Map<String, dynamic> json) {
    return HourlyUnits(
      time: json['time'] ?? '',
      temperature2M: json['temperature_2m'] ?? '',
      precipitationProbability: json['precipitation_probability'] ?? '',
      precipitation: json['precipitation'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'temperature_2m': temperature2M,
      'precipitation_probability': precipitationProbability,
      'precipitation': precipitation,
    };
  }
}
