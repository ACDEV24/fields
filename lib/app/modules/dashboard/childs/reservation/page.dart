import 'package:fields/app/models/field.dart';
import 'package:fields/app/modules/dashboard/childs/reservation/bloc/bloc.dart';
import 'package:fields/app/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ReservationPage extends StatelessWidget {
  final Field field;
  const ReservationPage({
    Key? key,
    required this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Modular.get<ReservationBloc>(),
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return BlocListener<ReservationBloc, ReservationState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Crear Reservación',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            const SizedBox(height: 16.0),
            const FieldsInput(
              hintText: 'Nombre de quien reserva',
            ),
            const SizedBox(height: 8.0),
            FieldsInput(
              controller: controller,
              hintText: 'Fecha en la que quiere reservar',
            ),
          ],
        ),
      ),
    );
  }
}
