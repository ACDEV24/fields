import 'package:fields/app/models/field.dart';
import 'package:fields/app/modules/dashboard/childs/reservation/bloc/bloc.dart';
import 'package:fields/app/utils/extensions.dart';
import 'package:fields/app/widgets/input.dart';
import 'package:fields/app/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;

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
      child: _Content(
        field: field,
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final Field field;
  const _Content({
    Key? key,
    required this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(
      text: Modular.get<ReservationBloc>().state.model.date?.format,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reservar cancha ${field.name}',
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 200.0,
            width: double.infinity,
            child: Hero(
              tag: field.uuid,
              child: CachedImage(
                url: field.image,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          const FieldsInput(
            hintText: 'Nombre de quien reserva',
          ),
          const SizedBox(height: 16.0),
          BlocBuilder<ReservationBloc, ReservationState>(
            builder: (context, state) {
              return FieldsInput(
                controller: controller,
                hasFocus: false,
                hintText: 'Fecha en la que quiere reservar',
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: state.model.date ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                  );

                  if (picked != null) {
                    Modular.get<ReservationBloc>().add(
                      ChangeDateEvent(picked),
                    );
                    controller.text = picked.format;
                    Modular.get<ReservationBloc>().add(
                      LoadWeatherEvent(
                        picked.format,
                      ),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
