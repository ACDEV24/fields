import 'package:fields/app/models/field.dart';
import 'package:fields/app/models/weather.dart';
import 'package:fields/app/modules/dashboard/childs/reservation/repository.dart';
import 'package:fields/app/modules/dashboard/repositories/reservations/service.dart';
import 'package:fields/app/utils/log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'event.dart';
part 'state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final ReservationWeatherRepository repository;
  final ReservationsService reservationsService;

  ReservationBloc({
    required this.repository,
    required this.reservationsService,
  }) : super(const InitialState(Model())) {
    on<LoadWeatherEvent>(_loadWeatherEvent);
    on<ChangeUserNameEvent>(_changeUserNameEvent);
    on<ChangeDateEvent>(_changeDateEvent);
    on<ChangeFieldEvent>(_changeFieldEvent);
    on<SaveReservationEvent>(_saveReservationEvent);
    on<ClearEvent>(_clearEvent);
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

  void _saveReservationEvent(
    SaveReservationEvent event,
    Emitter<ReservationState> emit,
  ) async {
    emit(SavingReservationState(state.model));

    try {
      await reservationsService.createReservation(
        fieldUuid: event.fieldUuid,
        date: event.date,
        userName: event.userName,
      );
      emit(SavedReservationState(state.model));
    } catch (error, stackTrace) {
      AppLogger.error(error, stackTrace);
      emit(ErrorSavingReservationState(state.model));
    }
  }

  void _changeUserNameEvent(
    ChangeUserNameEvent event,
    Emitter<ReservationState> emit,
  ) async {
    emit(
      ChangedUserNameState(
        state.model.copyWith(
          userName: event.userName,
        ),
      ),
    );
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

  void _clearEvent(
    ClearEvent event,
    Emitter<ReservationState> emit,
  ) async {
    emit(const InitialState(Model()));
  }
}
