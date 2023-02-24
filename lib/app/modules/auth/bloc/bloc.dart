import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fields/app/models/user.dart';
import 'package:fields/app/modules/auth/repository.dart';
import 'package:fields/app/config/config.dart';
import 'package:fields/app/utils/preferences.dart';

part 'event.dart';
part 'state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  final Preferences prefs;
  TextEditingController? codeController;
  Timer? codeTimer;

  AuthBloc({
    required this.repository,
    required this.prefs,
  }) : super(const InitialState(Model())) {
    on<ChangePhoneEvent>(_changePhoneEvent);
    on<SendCodeEvent>(_sendCodeEvent);
    on<ChangeCodeEvent>(_changeCodeEvent);
    on<ValidateCodeEvent>(_validateCodeEvent);
  }

  void _changePhoneEvent(
    ChangePhoneEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      ChangedPhoneState(
        state.model.copyWith(
          phone: event.phone,
        ),
      ),
    );
  }

  void _changeCodeEvent(
    ChangeCodeEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      ChangedPhoneState(
        state.model.copyWith(
          code: event.code,
        ),
      ),
    );

    if (event.code.length == 4) {
      FocusManager.instance.primaryFocus?.unfocus();
      await Future.delayed(const Duration(milliseconds: 300));
      add(const ValidateCodeEvent());
    }
  }

  void _sendCodeEvent(
    SendCodeEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(SendingCodeState(state.model));

    try {
      await repository.sendCode(state.model.phone);

      emit(SendedCodeState(state.model.copyWith()));
      // _startTimer();
    } catch (_) {
      emit(ErrorSendingCodeState(state.model));
      debugPrint(_.toString());
    }
  }

  void _validateCodeEvent(
    ValidateCodeEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(ValidatingCodeState(state.model));

    try {
      final user = await repository.validateCode(
        state.model.phone,
        state.model.code,
      );

      AppConfig.user = user;

      emit(
        CodeValidatedState(
          state.model.copyWith(
            user: user,
          ),
        ),
      );
    } catch (_) {
      emit(ErrorValidatingCodeState(state.model));
      debugPrint(_.toString());
    }
  }
}
