part of 'bloc.dart';

abstract class FieldDetailEvent extends Equatable {
  const FieldDetailEvent();

  @override
  List<Object> get props => [];
}

class ChangeDetailVisibitilyEvent extends FieldDetailEvent {
  const ChangeDetailVisibitilyEvent();
}
