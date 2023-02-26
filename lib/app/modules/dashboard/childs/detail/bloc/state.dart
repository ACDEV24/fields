part of 'bloc.dart';

@immutable
abstract class FieldDetailState extends Equatable {
  final Model model;
  const FieldDetailState(this.model);

  @override
  List<Object> get props => [model];
}

class InitialState extends FieldDetailState {
  const InitialState(Model model) : super(model);
}

class ChangedDetailVisivilityState extends FieldDetailState {
  const ChangedDetailVisivilityState(Model model) : super(model);
}

class ErrorState extends FieldDetailState {
  const ErrorState(Model model) : super(model);
}

class Model extends Equatable {
  final bool visible;
  const Model({
    this.visible = false,
  });

  Model copyWith({
    bool? visible,
  }) {
    return Model(
      visible: visible ?? this.visible,
    );
  }

  @override
  List<Object> get props {
    return [
      visible,
    ];
  }
}
