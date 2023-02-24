import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'event.dart';
part 'state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const InitialState(Model())) {
    on<LoadEvent>(_loadEvent);
  }

  void _loadEvent(LoadEvent event, Emitter<DashboardState> emit) async {
    emit(LoadingState(state.model));

    try {
      emit(LoadedState(state.model));

      emit(LoadedState(state.model.copyWith()));
    } catch (_) {
      emit(ErrorState(state.model));
    }
  }
}
