import 'package:fields/app/models/field.dart';
import 'package:fields/app/modules/dashboard/bloc/bloc.dart';
import 'package:fields/app/modules/dashboard/childs/detail/bloc/bloc.dart';
import 'package:fields/app/modules/dashboard/childs/detail/page.dart';
import 'package:fields/app/modules/dashboard/childs/reservation/bloc/bloc.dart';
import 'package:fields/app/modules/dashboard/childs/reservation/page.dart';
import 'package:fields/app/modules/dashboard/childs/reservation/repository.dart';
import 'package:fields/app/modules/dashboard/repositories/reservations/repository.dart';
import 'package:fields/app/modules/dashboard/repositories/reservations/service.dart';
import 'package:fields/app/modules/dashboard/repositories/fields/repository.dart';
import 'package:fields/app/modules/dashboard/repositories/fields/service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'page.dart';

class DashboardModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => DashboardBloc(
        fieldsService: i.get(),
        reservationsService: i.get(),
      )
        ..add(const LoadFieldsEvent())
        ..add(const LoadReservationsEvent()),
    ),
    Bind.lazySingleton((i) => FieldsService(repository: i.get())),
    Bind.lazySingleton((i) => FieldsRepository()),
    Bind.lazySingleton((i) => ReservationsService(repository: i.get())),
    Bind.lazySingleton((i) => ReservationsRepository()),
    Bind.lazySingleton((i) => FieldDetailBloc()),
    Bind.lazySingleton(
      (i) => ReservationBloc(
        repository: i.get(),
      ),
    ),
    Bind.lazySingleton(
      (i) => ReservationWeatherRepository(
        dio: i.get(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const DashboardPage(),
    ),
    ChildRoute(
      '/field/detail',
      child: (context, args) => FieldDetailPage(
        field: args.data as Field,
      ),
    ),
    ChildRoute(
      '/field/reservation',
      child: (context, args) => ReservationPage(
        field: args.data as Field,
      ),
    ),
  ];
}
