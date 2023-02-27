import 'package:fields/app/database/config.dart';

class ReservationsRepository {
  final database = DatabaseConfig.database;

  Future<List<Map<String, Object?>>> getReservations() async {
    return await database.rawQuery(
      'SELECT b.*, f.* FROM ${DatabaseConfig.reservationsDBName} b INNER JOIN fields f ON b.field_uuid = f.uuid',
    );
  }

  Future<List<Map<String, Object?>>> getReservationByUuid(String uuid) async {
    return await database.rawQuery(
      'SELECT b.*, f.* FROM ${DatabaseConfig.reservationsDBName} b INNER JOIN fields f ON b.field_uuid = f.uuid WHERE b.uuid = \'$uuid\'',
    );
  }

  Future<int> createReservation({
    String? uuid,
    String? userName,
    String? fieldUuid,
    DateTime? date,
  }) async {
    return await database.rawInsert(
      'INSERT INTO ${DatabaseConfig.reservationsDBName}(uuid, user_name, field_uuid, date) VALUES (\'$uuid\', \'$userName\', \'$fieldUuid\', \'$date\')',
    );
  }

  Future<int> updateReservation({
    required String uuid,
    String? userName,
    String? fieldUuid,
    DateTime? date,
  }) async {
    return await database.rawUpdate(
      'UPDATE ${DatabaseConfig.reservationsDBName}'
      'SET user_name = \'$userName\', '
      'field_uuid = \'$fieldUuid\', '
      'date = \'$date\' '
      'WHERE uuid = \'$uuid\'',
    );
  }

  Future<int> deleteReservation(String uuid) async {
    return await database.rawDelete(
      'DELETE FROM ${DatabaseConfig.reservationsDBName} WHERE uuid = \'$uuid\'',
    );
  }
}
