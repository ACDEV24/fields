import 'package:fields/app/models/reservation.dart';
import 'package:fields/app/models/field.dart';
import 'package:fields/app/modules/dashboard/repositories/reservations/service.dart';
import 'package:fields/app/modules/dashboard/repositories/fields/service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'event.dart';
part 'state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final FieldsService fieldsService;
  final ReservationsService reservationsService;

  DashboardBloc({
    required this.fieldsService,
    required this.reservationsService,
  }) : super(const InitialState(Model())) {
    on<LoadFieldsEvent>(_loadFieldsEvent);
    on<LoadReservationsEvent>(_loadReservationsEvent);
  }

  void _loadFieldsEvent(
    LoadFieldsEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(LoadingFieldsState(state.model));

    try {
      final fields = await fieldsService.getFields();

      emit(
        LoadedFieldsState(
          state.model.copyWith(
            fields: fields,
          ),
        ),
      );
    } catch (_) {
      emit(ErrorLoadingFieldsState(state.model));
    }
  }

  void _loadReservationsEvent(
    LoadReservationsEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(LoadingReservationsState(state.model));

    try {
      final reservations = await reservationsService.getReservations();

      emit(
        LoadedReservationsState(
          state.model.copyWith(
            reservations: reservations,
          ),
        ),
      );
    } catch (_) {
      emit(ErrorLoadingReservationsState(state.model));
    }
  }
}
