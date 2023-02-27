import 'package:bloc_test/bloc_test.dart';
import 'package:fields/app/models/weather.dart';
import 'package:fields/app/modules/dashboard/childs/reservation/bloc/bloc.dart';
import 'package:fields/app/modules/dashboard/childs/reservation/repository.dart';
import 'package:fields/app/modules/dashboard/repositories/reservations/service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockReservationWeatherRepository extends Mock
    implements ReservationWeatherRepository {}

class MockReservationsService extends Mock implements ReservationsService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const model = Model();
  final repository = MockReservationWeatherRepository();
  final reservationsService = MockReservationsService();
  final weatherJson = <String, dynamic>{
    'latitude': 10.5,
    'longitude': -75.5,
    'generationtime_ms': 0.2999305725097656,
    'utc_offset_seconds': 0,
    'timezone': 'GMT',
    'timezone_abbreviation': 'GMT',
    'elevation': 30,
    'hourly_units': {
      'time': 'iso8601',
      'temperature_2m': '°C',
      'precipitation_probability': '%',
      'precipitation': 'mm'
    },
    'hourly': {
      'time': [
        '2023-02-26T00:00',
        '2023-02-26T01:00',
        '2023-02-26T02:00',
        '2023-02-26T03:00',
        '2023-02-26T04:00',
        '2023-02-26T05:00',
        '2023-02-26T06:00',
        '2023-02-26T07:00',
        '2023-02-26T08:00',
        '2023-02-26T09:00',
        '2023-02-26T10:00',
        '2023-02-26T11:00',
        '2023-02-26T12:00',
        '2023-02-26T13:00',
        '2023-02-26T14:00',
        '2023-02-26T15:00',
        '2023-02-26T16:00',
        '2023-02-26T17:00',
        '2023-02-26T18:00',
        '2023-02-26T19:00',
        '2023-02-26T20:00',
        '2023-02-26T21:00',
        '2023-02-26T22:00',
        '2023-02-26T23:00'
      ],
      'temperature_2m': [
        25,
        24.7,
        24.7,
        24.7,
        24.6,
        24.5,
        24.1,
        23.9,
        23.8,
        23.6,
        23.6,
        23.4,
        23.6,
        25.4,
        27.8,
        30.3,
        32.3,
        33.8,
        34.2,
        31.8,
        30.4,
        29.6,
        28.1,
        26.4
      ],
      'precipitation_probability': [
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0
      ],
      'precipitation': [
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0
      ]
    }
  };
  final weather = Weather.fromJson(weatherJson);
  final now = DateTime.now();

  blocTest<ReservationBloc, ReservationState>(
    'emits [LoadingWeatherState, LoadedWeatherState] when LoadWeatherEvent is called.',
    build: () {
      when(() => repository.getWeather('2023-02-27')).thenAnswer(
        (_) async => weather,
      );
      return ReservationBloc(
        repository: repository,
        reservationsService: reservationsService,
      );
    },
    act: (bloc) => bloc.add(const LoadWeatherEvent('2023-02-27')),
    expect: () => [
      const LoadingWeatherState(model),
      LoadedWeatherState(
        model.copyWith(
          weather: weather,
        ),
      ),
    ],
  );

  blocTest<ReservationBloc, ReservationState>(
    'emits [LoadingWeatherState, LoadedWeatherState] when LoadWeatherEvent is called and JSON is empty.',
    build: () {
      when(() => repository.getWeather('2023-02-27')).thenAnswer(
        (_) async => Weather.fromJson({}),
      );
      return ReservationBloc(
        repository: repository,
        reservationsService: reservationsService,
      );
    },
    act: (bloc) => bloc.add(const LoadWeatherEvent('2023-02-27')),
    expect: () => [
      const LoadingWeatherState(model),
      isA<LoadedWeatherState>(),
    ],
  );

  blocTest<ReservationBloc, ReservationState>(
    'emits [LoadingWeatherState, ErrorLoadingWeatherState] when LoadWeatherEvent is called and it fails.',
    build: () {
      when(() => repository.getWeather('2023-02-27')).thenThrow(
        (_) async => any,
      );
      return ReservationBloc(
        repository: repository,
        reservationsService: reservationsService,
      );
    },
    act: (bloc) => bloc.add(const LoadWeatherEvent('2023-02-27')),
    expect: () => const [
      LoadingWeatherState(model),
      ErrorLoadingWeatherState(model),
    ],
  );

  blocTest<ReservationBloc, ReservationState>(
    'emits [ChangedUserNameState] when ChangeUserNameEvent is called.',
    build: () {
      return ReservationBloc(
        repository: repository,
        reservationsService: reservationsService,
      );
    },
    act: (bloc) => bloc.add(const ChangeUserNameEvent('Test')),
    expect: () => [
      ChangedUserNameState(
        model.copyWith(
          userName: 'Test',
        ),
      ),
    ],
  );

  blocTest<ReservationBloc, ReservationState>(
    'emits [ChangedDateState] when ChangeDateEvent is called.',
    build: () {
      return ReservationBloc(
        repository: repository,
        reservationsService: reservationsService,
      );
    },
    act: (bloc) => bloc.add(ChangeDateEvent(now)),
    expect: () => [
      ChangedDateState(
        model.copyWith(
          date: now,
        ),
      ),
    ],
  );

  blocTest<ReservationBloc, ReservationState>(
    'emits [InitialState] when ClearEvent is called.',
    build: () {
      return ReservationBloc(
        repository: repository,
        reservationsService: reservationsService,
      );
    },
    act: (bloc) => bloc.add(const ClearEvent()),
    expect: () => [
      const InitialState(Model()),
    ],
  );

  blocTest<ReservationBloc, ReservationState>(
    'emits [SavingReservationState, SavedReservationState] when SaveReservationEvent is called.',
    build: () {
      when(
        () => reservationsService.createReservation(
          userName: '',
          fieldUuid: '',
          date: now,
        ),
      ).thenAnswer(
        (_) async => any,
      );
      return ReservationBloc(
        repository: repository,
        reservationsService: reservationsService,
      );
    },
    act: (bloc) => bloc.add(
      SaveReservationEvent(
        userName: '',
        fieldUuid: '',
        date: now,
      ),
    ),
    expect: () => [
      const SavingReservationState(model),
      const SavedReservationState(model),
    ],
  );

  blocTest<ReservationBloc, ReservationState>(
    'emits [SavingReservationState, ErrorSavingReservationState] when SaveReservationEvent is called and it fails.',
    build: () {
      when(
        () => reservationsService.createReservation(
          userName: '',
          fieldUuid: '',
          date: now,
        ),
      ).thenThrow(
        (_) async => any,
      );
      return ReservationBloc(
        repository: repository,
        reservationsService: reservationsService,
      );
    },
    act: (bloc) => bloc.add(
      SaveReservationEvent(
        userName: '',
        fieldUuid: '',
        date: now,
      ),
    ),
    expect: () => [
      const SavingReservationState(model),
      const ErrorSavingReservationState(model),
    ],
  );
}
