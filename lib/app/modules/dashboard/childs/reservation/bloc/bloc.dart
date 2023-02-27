import 'package:fields/app/models/field.dart';
import 'package:fields/app/models/weather.dart';
import 'package:fields/app/modules/dashboard/childs/reservation/repository.dart';
import 'package:fields/app/utils/log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'event.dart';
part 'state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final ReservationWeatherRepository repository;

  ReservationBloc({
    required this.repository,
  }) : super(const InitialState(Model())) {
    on<LoadWeatherEvent>(_loadWeatherEvent);
    on<ChangeDateEvent>(_changeDateEvent);
    on<ChangeFieldEvent>(_changeFieldEvent);
  }

  void _loadWeatherEvent(
    LoadWeatherEvent event,
    Emitter<ReservationState> emit,
  ) async {
    emit(LoadingWeatherState(state.model));

    try {
      final weather = await repository.getWeather(event.date);

      emit(
        LoadedWeatherState(
          state.model.copyWith(
            weather: weather,
          ),
        ),
      );
    } catch (error, stackTrace) {
      AppLogger.error(error, stackTrace);
      emit(ErrorLoadingWeatherState(state.model));
    }
  }

  void _changeFieldEvent(
    ChangeFieldEvent event,
    Emitter<ReservationState> emit,
  ) async {
    emit(
      ChangedFieldState(
        state.model.copyWith(
          field: event.field,
        ),
      ),
    );
  }

  void _changeDateEvent(
    ChangeDateEvent event,
    Emitter<ReservationState> emit,
  ) async {
    emit(
      ChangedDateState(
        state.model.copyWith(
          date: event.date,
        ),
      ),
    );
  }
}
