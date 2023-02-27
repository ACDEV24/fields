import 'package:fields/app/models/reservation.dart';
import 'package:fields/app/modules/dashboard/bloc/bloc.dart';
import 'package:fields/app/modules/dashboard/widgets/field.dart';
import 'package:fields/app/utils/extensions.dart';
import 'package:fields/app/utils/loading.dart';
import 'package:fields/app/utils/toasts.dart';
import 'package:fields/app/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Modular.get<DashboardBloc>(),
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardBloc, DashboardState>(
      listener: listener,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            centerTitle: true,
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Text(
                    'Canchas',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Tab(
                  icon: Text(
                    'Reservaciones',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: const Center(
            child: TabBarView(
              children: [
                _Fields(),
                _Reservations(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void listener(BuildContext context, DashboardState state) {
    if (state is ChangeIndexState) {
      DefaultTabController.of(context).animateTo(state.model.index);
    }

    if (state is DeletingReservationsState) {
      Loading.show(context);
    }

    if (state is DeletedReservationsState) {
      Modular.to.pop();
      Fields.showSuccess('Reservación eliminada');
      Modular.get<DashboardBloc>().add(const LoadReservationsEvent());
      Modular.get<DashboardBloc>().add(const LoadFieldsEvent());
    }
  }
}

class _Fields extends StatelessWidget {
  const _Fields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        final fields = state.model.fields;

        return RefreshIndicator(
          onRefresh: () async {
            Modular.get<DashboardBloc>().add(const LoadFieldsEvent());
          },
          child: ListView.builder(
            itemCount: fields.length,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            itemBuilder: (context, index) {
              final field = fields[index];
              return FieldWidget(
                field: field,
                onFieldTap: () {
                  Modular.to.pushNamed(
                    '/dashboard/field/detail',
                    arguments: field,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class _Reservations extends StatelessWidget {
  const _Reservations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state.model.reservations.isEmpty) {
          return const Center(
            child: Text(
              'No hay reservaciones creadas',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            Modular.get<DashboardBloc>().add(const LoadReservationsEvent());
          },
          child: ListView.builder(
            itemCount: state.model.reservations.length,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            itemBuilder: (context, index) {
              final reservation = state.model.reservations[index];
              return _Reservation(
                reservation: reservation,
              );
            },
          ),
        );
      },
    );
  }
}

class _Reservation extends StatelessWidget {
  final Reservation reservation;
  const _Reservation({
    Key? key,
    required this.reservation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0).copyWith(
              topRight: Radius.zero,
              bottomRight: Radius.zero,
            ),
            child: Hero(
              tag: reservation.uuid,
              child: CachedImage(
                url: reservation.field.image,
                width: 150,
                height: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Cancha: ',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: reservation.field.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        text: 'Reservada por: ',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: reservation.userName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        text: 'Fecha: ',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: reservation.date.format,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () async {
                        final deleteConfirmation = await showDialog<bool>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Center(
                                child: Text('Cancelar reserva'),
                              ),
                              content: const Text(
                                '¿Estas seguro que deseas eliminar la reserva?',
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.green[300],
                                      ),
                                      child: const Text(
                                        'No',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Modular.to.pop(false);
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      onPressed: () {
                                        Modular.to.pop(true);
                                      },
                                      child: const Text(
                                        'Si',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                        if (deleteConfirmation ?? false) {
                          Modular.get<DashboardBloc>().add(
                            DeleteReservationEvent(
                              reservation.uuid,
                            ),
                          );
                        }
                      },
                      child: const Text('Eliminar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
