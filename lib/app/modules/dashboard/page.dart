import 'package:fields/app/models/field.dart';
import 'package:fields/app/modules/dashboard/bloc/bloc.dart';
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
            return _Field(
              field: fields[index],
            );
          },
        );
      },
    );
  }
}

class _Field extends StatelessWidget {
  final Field field;
  const _Field({
    Key? key,
    required this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed('/dashboard/field/detail', arguments: field);
      },
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
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
              child: CachedImage(
                url: field.image,
                width: 150,
                height: double.infinity,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          field.name,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          field.description,
                          style: const TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Precio: ',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: '\$${field.price}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Reservations extends StatelessWidget {
  const _Reservations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Reservación $index'),
        );
      },
    );
  }
}
