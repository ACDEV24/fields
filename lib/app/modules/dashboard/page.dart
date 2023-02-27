import 'package:fields/app/modules/dashboard/bloc/bloc.dart';
import 'package:fields/app/modules/dashboard/widgets/field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Modular.get<DashboardBloc>(),
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
                Modular.to.pushNamed(
                  '/dashboard/field/detail',
                  arguments: field,
                );
              },
            );
          },
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
        return ListView.builder(
          itemCount: state.model.reservations.length,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Reservación $index'),
            );
          },
        );
      },
    );
  }
}
