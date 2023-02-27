import 'package:animate_do/animate_do.dart';
import 'package:fields/app/models/field.dart';
import 'package:fields/app/modules/dashboard/childs/reservation/bloc/bloc.dart';
import 'package:fields/app/utils/extensions.dart';
import 'package:fields/app/utils/theme.dart';
import 'package:fields/app/widgets/input.dart';
import 'package:fields/app/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:intl/intl.dart';

class ReservationPage extends StatelessWidget {
  final Field field;
  const ReservationPage({
    Key? key,
    required this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Modular.get<ReservationBloc>()..add(ChangeFieldEvent(field)),
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(
      text: Modular.get<ReservationBloc>().state.model.date?.format,
    );

    return BlocBuilder<ReservationBloc, ReservationState>(
      builder: (context, state) {
        final field = state.model.field;

        if (field == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

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
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
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
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final Field? selectedField = await Modular.to.pushNamed(
                      '/dashboard/field/select',
                      arguments: field,
                    );

                    if (selectedField == null) return;

                    Modular.get<ReservationBloc>().add(
                      ChangeFieldEvent(selectedField),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 12.0,
                    ),
                    child: Text(
                      'Cambiar cancha',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const FieldsInput(
                hintText: 'Nombre de quien reserva',
              ),
              const SizedBox(height: 16.0),
              _SelectDate(controller: controller),
              const SizedBox(height: 16.0),
              const _Weather(),
            ],
          ),
        );
      },
    );
  }
}

class _SelectDate extends StatelessWidget {
  final TextEditingController controller;

  const _SelectDate({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationBloc, ReservationState>(
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
              lastDate: DateTime(2023, 03, 14),
            );

            if (picked != null) {
              Modular.get<ReservationBloc>().add(
                ChangeDateEvent(picked),
              );
              controller.text = picked.format;
              Modular.get<ReservationBloc>().add(
                LoadWeatherEvent(
                  picked.formatYYYYMMDD,
                ),
              );
            }
          },
        );
      },
    );
  }
}

class _Weather extends StatelessWidget {
  const _Weather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationBloc, ReservationState>(
      builder: (context, state) {
        if (state.model.weather == null) {
          return const SizedBox.shrink();
        }

        return FadeIn(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Column(
              children: List.generate(
                state.model.weather?.hourly.precipitationProbability.length ??
                    0,
                (index) {
                  final hourly = state.model.weather?.hourly;
                  final time = DateFormat('hh:mm a')
                      .format(hourly?.time[index] ?? DateTime.now());
                  final precipitationProbability =
                      hourly?.precipitationProbability[index];
                  final temperature = hourly?.temperature2M[index];

                  return ListTile(
                    title: Text(
                      time,
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    subtitle: Text(
                      'Porcentaje de lluvia: ${precipitationProbability?.toString() ?? ''}%',
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    trailing: Text(
                      'Temperatura: ${temperature?.toString() ?? ''}°',
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
