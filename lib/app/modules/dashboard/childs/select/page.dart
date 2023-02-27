import 'package:fields/app/modules/dashboard/bloc/bloc.dart';
import 'package:fields/app/modules/dashboard/widgets/field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SelectFieldPage extends StatelessWidget {
  const SelectFieldPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Modular.get<DashboardBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Seleccionar cancha'),
          centerTitle: true,
        ),
        body: Column(
          children: const [
            SizedBox(height: 12.0),
            Text(
              'Selecciona la cancha que deseas reservar',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.0),
            Expanded(
              child: _Fields(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Fields extends StatelessWidget {
  const _Fields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        final fields = state.model.fields;

        return ListView.builder(
          itemCount: fields.length,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemBuilder: (context, index) {
            final field = fields[index];
            return FieldWidget(
              field: field,
              onFieldTap: () {
                Modular.to.pop(field);
              },
            );
          },
        );
      },
    );
  }
}
