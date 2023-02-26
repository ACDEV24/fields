part of 'bloc.dart';

@immutable
abstract class DashboardState extends Equatable {
  final Model model;
  const DashboardState(this.model);

  @override
  List<Object> get props => [model];
}

class InitialState extends DashboardState {
  const InitialState(Model model) : super(model);
}

class LoadingFieldsState extends DashboardState {
  const LoadingFieldsState(Model model) : super(model);
}

class LoadedFieldsState extends DashboardState {
  const LoadedFieldsState(Model model) : super(model);
}

class ErrorLoadingFieldsState extends DashboardState {
  const ErrorLoadingFieldsState(Model model) : super(model);
}

class LoadingReservationsState extends DashboardState {
  const LoadingReservationsState(Model model) : super(model);
}

class LoadedReservationsState extends DashboardState {
  const LoadedReservationsState(Model model) : super(model);
}

class ErrorLoadingReservationsState extends DashboardState {
  const ErrorLoadingReservationsState(Model model) : super(model);
}

class Model extends Equatable {
  final List<Field> fields;
  final List<Reservation> reservations;
  const Model({
    this.fields = const [],
    this.reservations = const [],
  });

  Model copyWith({
    List<Field>? fields,
    List<Reservation>? reservations,
  }) {
    return Model(
      fields: fields ?? this.fields,
      reservations: reservations ?? this.reservations,
    );
  }

  @override
  List<Object> get props {
    return [
      fields,
      reservations,
    ];
  }
}
