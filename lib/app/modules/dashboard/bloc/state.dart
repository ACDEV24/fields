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

class LoadingState extends DashboardState {
  const LoadingState(Model model) : super(model);
}

class LoadedState extends DashboardState {
  const LoadedState(Model model) : super(model);
}

class ErrorState extends DashboardState {
  const ErrorState(Model model) : super(model);
}

class Model extends Equatable {
  const Model();

  Model copyWith() => const Model();

  @override
  List<Object> get props => [];
}
