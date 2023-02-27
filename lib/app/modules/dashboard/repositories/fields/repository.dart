import 'package:fields/app/database/config.dart';
import 'package:uuid/uuid.dart';

class FieldsRepository {
  final database = DatabaseConfig.database;

  FieldsRepository() {
    getFields().then((value) {
      if (value.isNotEmpty) return;

      createField(
        uuid: const Uuid().v1(),
        name: 'A',
        description:
            'Cancha A es una cancha de futbol de césped natural con iluminación, ideal para jugar con tus amigos.',
        price: 10.0,
        image:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/Cancha_sintetica.jpg/1200px-Cancha_sintetica.jpg',
      );

      createField(
        uuid: const Uuid().v1(),
        name: 'B',
        description:
            'Cancha B es una cancha de Tenis con piso de goma para amortiguar el impacto de la pelota. Cuenta con iluminación y es al aire libre.',
        price: 15.0,
        image:
            'https://universal-sport-instalaciones.com/sites/default/files/2021-02/el%20estadio%20%284%29_0.jpg',
      );

      createField(
        uuid: const Uuid().v1(),
        name: 'C',
        description:
            'Cancha C es una cancha multiple, puedes jugar basketball, futbol y voleyball. Cuenta con iluminación para jugar a la hora que desees con tus amigos.',
        price: 20.0,
        image:
            'https://www.parqueygrama.com/wp-content/uploads/2018/11/construccion-de-cancha-multiple.jpg',
      );
    });
  }

  Future<int> createField({
    required String uuid,
    required String name,
    required String description,
    required double price,
    required String image,
  }) async {
    return await database.rawInsert(
      'INSERT INTO ${DatabaseConfig.fieldsDBName}(uuid, name, description, price, image) VALUES (\'$uuid\', \'$name\', \'$description\', \'$price\', \'$image\')',
    );
  }

  Future<List<Map<String, Object?>>> getFields() async {
    return await database.rawQuery(
      'SELECT f.*, COUNT(b.field_uuid) AS num_reservations FROM ${DatabaseConfig.fieldsDBName} f LEFT JOIN ${DatabaseConfig.reservationsDBName} b ON f.uuid = b.field_uuid GROUP BY f.uuid, f.name;',
    );
  }

  Future<List<Map<String, Object?>>> getFieldByUuid(String uuid) async {
    return await database.rawQuery(
      'SELECT * FROM ${DatabaseConfig.fieldsDBName} WHERE uuid = \'$uuid\'',
    );
  }

  Future<int> updateField({
    String? uuid,
    String? name,
    String? description,
    double? price,
    String? image,
  }) async {
    return await database.rawUpdate(
      'UPDATE ${DatabaseConfig.fieldsDBName} SET name = \'$name\', description = \'$description\', price = \'$price\', image = \'$image\' WHERE uuid = \'$uuid\'',
    );
  }

  Future<int> deleteField(String uuid) async {
    return await database.rawDelete(
      'DELETE FROM ${DatabaseConfig.fieldsDBName} WHERE uuid = \'$uuid\'',
    );
  }
}
