part of 'bloc.dart';

@immutable
abstract class ConfigState extends Equatable {
  final Model model;
  const ConfigState(this.model);

  @override
  List<Object> get props => [model];
}

class InitialState extends ConfigState {
  const InitialState(Model model) : super(model);
}

class ChangedUserState extends ConfigState {
  const ChangedUserState(Model model) : super(model);
}

class LoadingUserState extends ConfigState {
  const LoadingUserState(Model model) : super(model);
}

class LoadedUserState extends ConfigState {
  const LoadedUserState(Model model) : super(model);
}

class UnLoggedState extends ConfigState {
  const UnLoggedState(Model model) : super(model);
}

class NoResidentialSelected extends ConfigState {
  const NoResidentialSelected(Model model) : super(model);
}

class Model extends Equatable {
  final User? user;
  final UniqueKey key;

  const Model({
    this.user,
    required this.key,
  });

  Model copyWith({
    User? user,
    UniqueKey? key,
  }) {
    return Model(
      user: user ?? this.user,
      key: key ?? this.key,
    );
  }

  @override
  List<Object?> get props {
    return [
      user,
      key,
    ];
  }
}
