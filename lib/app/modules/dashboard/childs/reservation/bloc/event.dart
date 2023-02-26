part of 'bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class LoadFieldsEvent extends DashboardEvent {
  const LoadFieldsEvent();
}

class LoadReservationsEvent extends DashboardEvent {
  const LoadReservationsEvent();
}
