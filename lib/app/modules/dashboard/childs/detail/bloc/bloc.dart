import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'event.dart';
part 'state.dart';

class FieldDetailBloc extends Bloc<FieldDetailEvent, FieldDetailState> {
  FieldDetailBloc() : super(const InitialState(Model())) {
    on<ChangeDetailVisibitilyEvent>(_changeDetailVisibitilyEvent);
  }

  void _changeDetailVisibitilyEvent(
    ChangeDetailVisibitilyEvent event,
    Emitter<FieldDetailState> emit,
  ) {
    emit(
      ChangedDetailVisivilityState(
        state.model.copyWith(
          visible: !state.model.visible,
        ),
      ),
    );
  }
}
