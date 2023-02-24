part of 'bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class LoadEvent extends DashboardEvent {
  const LoadEvent();
}
