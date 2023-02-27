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

class ChangeIndexEvent extends DashboardEvent {
  final int index;
  const ChangeIndexEvent(this.index);
}

class DeleteReservationEvent extends DashboardEvent {
  final String uuid;
  const DeleteReservationEvent(this.uuid);
}
