import 'package:bloc_test/bloc_test.dart';
import 'package:fields/app/modules/dashboard/childs/detail/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const model = Model();

  blocTest<FieldDetailBloc, FieldDetailState>(
    'emits [ChangedDetailVisivilityState] when ChangeDetailVisibitilyEvent is called.',
    build: () {
      return FieldDetailBloc();
    },
    act: (bloc) => bloc.add(const ChangeDetailVisibitilyEvent()),
    expect: () => [
      ChangedDetailVisivilityState(
        model.copyWith(
          visible: !model.visible,
        ),
      ),
    ],
  );
}
