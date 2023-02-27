part of 'bloc.dart';

abstract class ReservationEvent extends Equatable {
  const ReservationEvent();

  @override
  List<Object> get props => [];
}

class LoadWeatherEvent extends ReservationEvent {
  final String date;
  const LoadWeatherEvent(this.date);
}

class ChangeDateEvent extends ReservationEvent {
  final DateTime date;
  const ChangeDateEvent(this.date);
}
