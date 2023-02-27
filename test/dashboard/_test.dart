import 'package:bloc_test/bloc_test.dart';
import 'package:fields/app/models/field.dart';
import 'package:fields/app/models/reservation.dart';
import 'package:fields/app/modules/dashboard/bloc/bloc.dart';
import 'package:fields/app/modules/dashboard/repositories/fields/service.dart';
import 'package:fields/app/modules/dashboard/repositories/reservations/service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

class MockFieldsService extends Mock implements FieldsService {}

class MockReservationsService extends Mock implements ReservationsService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const model = Model();
  final fieldsService = MockFieldsService();
  final reservationsService = MockReservationsService();
  final uuid = const Uuid().v1();
  final fields = List.generate(
    3,
    (index) {
      return Field(
        uuid: uuid,
        name: 'Field $index',
        description: 'Description $index',
        image: 'Image $index',
        price: 100,
        numReservations: 2 + index,
      );
    },
  );

  final reservations = List.generate(
    3,
    (index) {
      return Reservation(
        uuid: uuid,
        field: fields[index],
        fieldUuid: fields[index].uuid,
        userName: 'User $index',
        date: DateTime.now(),
      );
    },
  );

  blocTest<DashboardBloc, DashboardState>(
    'emits [ChangeIndexState] when changeIndexEvent is called.',
    build: () {
      return DashboardBloc(
        fieldsService: fieldsService,
        reservationsService: reservationsService,
      );
    },
    act: (bloc) => bloc.add(const ChangeIndexEvent(1)),
    expect: () => [
      ChangeIndexState(
        model.copyWith(
          index: 1,
        ),
      ),
    ],
  );

  blocTest<DashboardBloc, DashboardState>(
    'emits [LoadFieldsState] when LoadFieldsEvent is loaded.',
    build: () {
      when(() => fieldsService.getFields()).thenAnswer((_) async => fields);
      return DashboardBloc(
        fieldsService: fieldsService,
        reservationsService: reservationsService,
      );
    },
    act: (bloc) => bloc.add(const LoadFieldsEvent()),
    expect: () => [
      const LoadingFieldsState(model),
      LoadedFieldsState(
        model.copyWith(
          fields: fields,
        ),
      ),
    ],
  );

  blocTest<DashboardBloc, DashboardState>(
    'emits [ErrorLoadingFieldsState] when LoadFieldsEvent fails.',
    build: () {
      when(() => fieldsService.getFields()).thenThrow((_) async => null);
      return DashboardBloc(
        fieldsService: fieldsService,
        reservationsService: reservationsService,
      );
    },
    act: (bloc) => bloc.add(const LoadFieldsEvent()),
    expect: () => const [
      LoadingFieldsState(model),
      ErrorLoadingFieldsState(model),
    ],
  );

  blocTest<DashboardBloc, DashboardState>(
    'emits [LoadReservationsState] when LoadReservationsEvent is loaded.',
    build: () {
      when(() => reservationsService.getReservations())
          .thenAnswer((_) async => reservations);
      return DashboardBloc(
        fieldsService: fieldsService,
        reservationsService: reservationsService,
      );
    },
    act: (bloc) => bloc.add(const LoadReservationsEvent()),
    expect: () => [
      const LoadingReservationsState(model),
      LoadedReservationsState(
        model.copyWith(
          reservations: reservations,
        ),
      ),
    ],
  );

  blocTest<DashboardBloc, DashboardState>(
    'emits [ErrorLoadingReservationsState] when LoadReservationsEvent fails.',
    build: () {
      when(() => fieldsService.getFields()).thenThrow((_) async => null);
      return DashboardBloc(
        fieldsService: fieldsService,
        reservationsService: reservationsService,
      );
    },
    act: (bloc) => bloc.add(const LoadFieldsEvent()),
    expect: () => const [
      LoadingFieldsState(model),
      ErrorLoadingFieldsState(model),
    ],
  );

  blocTest<DashboardBloc, DashboardState>(
    'emits [DeletedReservationsState] when DeleteReservationEvent is loaded.',
    build: () {
      when(() => reservationsService.deleteReservation('')).thenAnswer(
        (_) async => any,
      );
      return DashboardBloc(
        fieldsService: fieldsService,
        reservationsService: reservationsService,
      );
    },
    act: (bloc) => bloc.add(const DeleteReservationEvent('')),
    expect: () => const [
      DeletingReservationsState(model),
      DeletedReservationsState(model),
    ],
  );

  blocTest<DashboardBloc, DashboardState>(
    'emits [ErrorDeletingReservationsState] when DeleteReservationEvent fails.',
    build: () {
      when(() => reservationsService.deleteReservation(''))
          .thenThrow((_) async => null);
      return DashboardBloc(
        fieldsService: fieldsService,
        reservationsService: reservationsService,
      );
    },
    act: (bloc) => bloc.add(const DeleteReservationEvent('')),
    expect: () => const [
      DeletingReservationsState(model),
      ErrorDeletingReservationsState(model),
    ],
  );
}
