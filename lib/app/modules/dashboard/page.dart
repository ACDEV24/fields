import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: const Center(
        child: TabBarView(
          children: [
            Center(
              child: Text('Canchas'),
            ),
            Center(
              child: Text('Reservaciones'),
            ),
          ],
        ),
      ),
    );
  }
}
