part of 'bloc.dart';

@immutable
abstract class ReservationState extends Equatable {
  final Model model;
  const ReservationState(this.model);

  @override
  List<Object> get props => [model];
}

class InitialState extends ReservationState {
  const InitialState(Model model) : super(model);
}

class LoadingWeatherState extends ReservationState {
  const LoadingWeatherState(Model model) : super(model);
}

class LoadedWeatherState extends ReservationState {
  const LoadedWeatherState(Model model) : super(model);
}

class ErrorLoadingWeatherState extends ReservationState {
  const ErrorLoadingWeatherState(Model model) : super(model);
}

class LoadingReservationsState extends ReservationState {
  const LoadingReservationsState(Model model) : super(model);
}

class LoadedReservationsState extends ReservationState {
  const LoadedReservationsState(Model model) : super(model);
}

class ErrorLoadingReservationsState extends ReservationState {
  const ErrorLoadingReservationsState(Model model) : super(model);
}

class SavingReservationState extends ReservationState {
  const SavingReservationState(Model model) : super(model);
}

class SavedReservationState extends ReservationState {
  const SavedReservationState(Model model) : super(model);
}

class ErrorSavingReservationState extends ReservationState {
  const ErrorSavingReservationState(Model model) : super(model);
}

class ChangedUserNameState extends ReservationState {
  const ChangedUserNameState(Model model) : super(model);
}

class ChangedFieldState extends ReservationState {
  const ChangedFieldState(Model model) : super(model);
}

class ChangedDateState extends ReservationState {
  const ChangedDateState(Model model) : super(model);
}

class Model extends Equatable {
  final Field? field;
  final Weather? weather;
  final DateTime? date;
  final String userName;

  const Model({
    this.field,
    this.weather,
    this.date,
    this.userName = '',
  });

  Model copyWith({
    Field? field,
    Weather? weather,
    DateTime? date,
    String? userName,
  }) {
    return Model(
      field: field ?? this.field,
      weather: weather ?? this.weather,
      date: date ?? this.date,
      userName: userName ?? this.userName,
    );
  }

  bool get readyToSave => field != null && date != null && userName.isNotEmpty;

  @override
  List<Object?> get props {
    return [
      field,
      weather,
      date,
      userName,
    ];
  }
}
