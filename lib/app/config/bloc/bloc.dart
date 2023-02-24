import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fields/app/models/user.dart';
import 'package:fields/app/config/repository.dart';
import 'package:fields/app/utils/preferences.dart';

part 'event.dart';
part 'state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  final ConfigRepository repository;
  final Preferences prefs;
  ConfigBloc({
    required this.repository,
    required this.prefs,
  }) : super(InitialState(Model(key: UniqueKey()))) {
    on<ChangeUserEvent>(_changeUserEvent);
    on<LoadUserEvent>(_loadUserEvent);
    on<InitEvent>(_initEvent);
  }

  void _changeUserEvent(
    ChangeUserEvent event,
    Emitter<ConfigState> emit,
  ) async {
    emit(
      ChangedUserState(
        state.model.copyWith(
          user: event.user,
        ),
      ),
    );
  }

  void _initEvent(InitEvent event, Emitter<ConfigState> emit) async {
    if (!prefs.isLogged) {
      await Future.delayed(const Duration(milliseconds: 300));
      emit(UnLoggedState(state.model.copyWith()));
      return;
    }

    emit(LoadingUserState(state.model));

    try {
      await repository.getUserByUuid();

      if (!prefs.alreadySelectCurrent) {
        emit(NoResidentialSelected(state.model.copyWith()));
        return;
      }

      emit(LoadedUserState(state.model.copyWith()));
    } catch (_) {
      emit(UnLoggedState(state.model));
    }
  }

  void _loadUserEvent(LoadUserEvent event, Emitter<ConfigState> emit) async {
    emit(LoadingUserState(state.model));

    try {
      await repository.getUserByUuid();

      emit(LoadedUserState(state.model.copyWith()));
    } catch (_) {
      emit(UnLoggedState(state.model));
    }
  }
}
