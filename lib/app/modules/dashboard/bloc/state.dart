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

class DeletingReservationsState extends DashboardState {
  const DeletingReservationsState(Model model) : super(model);
}

class DeletedReservationsState extends DashboardState {
  const DeletedReservationsState(Model model) : super(model);
}

class ErrorDeletingReservationsState extends DashboardState {
  const ErrorDeletingReservationsState(Model model) : super(model);
}

class ChangeIndexState extends DashboardState {
  const ChangeIndexState(Model model) : super(model);
}

class Model extends Equatable {
  final List<Field> fields;
  final List<Reservation> reservations;
  final int index;
  const Model({
    this.fields = const [],
    this.reservations = const [],
    this.index = 0,
  });

  Model copyWith({
    List<Field>? fields,
    List<Reservation>? reservations,
    int? index,
  }) {
    return Model(
      fields: fields ?? this.fields,
      reservations: reservations ?? this.reservations,
      index: index ?? this.index,
    );
  }

  @override
  List<Object> get props {
    return [
      fields,
      reservations,
      index,
    ];
  }
}
