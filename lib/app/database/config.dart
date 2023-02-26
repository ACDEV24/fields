import 'package:sqflite/sqflite.dart';

class DatabaseConfig {
  static const fieldsDBName = 'fields';
  static const reservationsDBName = 'reservations';
  static late final Database database;

  Future<void> init() async {
    database = await openDatabase('my_db.db');
    createReservationTable();
    createFieldsTable();
  }

  Future<void> createReservationTable() async {
    await database.execute(
      'CREATE TABLE IF NOT EXISTS $reservationsDBName (uuid TEXT PRIMARY KEY, user_name TEXT, field_uuid TEXT, date DATE)',
    );
  }

  Future<void> createFieldsTable() async {
    await database.execute(
      'CREATE TABLE IF NOT EXISTS $fieldsDBName (uuid TEXT PRIMARY KEY, name TEXT, description TEXT, price DOUBLE, image TEXT)',
    );
  }

  Future<void> close() async {
    await database.close();
  }
}
