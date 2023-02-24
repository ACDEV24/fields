part of 'bloc.dart';

abstract class ConfigEvent extends Equatable {
  const ConfigEvent();

  @override
  List<Object> get props => [];
}

class ChangeUserEvent extends ConfigEvent {
  final User? user;
  const ChangeUserEvent(this.user);
}

class LoadUserEvent extends ConfigEvent {
  const LoadUserEvent();
}

class InitEvent extends ConfigEvent {
  const InitEvent();
}
