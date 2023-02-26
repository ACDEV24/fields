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

class Model extends Equatable {
  final Weather? weather;
  const Model({
    this.weather,
  });

  Model copyWith({
    Weather? weather,
  }) {
    return Model(
      weather: weather ?? this.weather,
    );
  }

  @override
  List<Object?> get props {
    return [
      weather,
    ];
  }
}
