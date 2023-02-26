import 'package:fields/app/models/field.dart';
import 'package:fields/app/modules/dashboard/repositories/fields/repository.dart';
import 'package:uuid/uuid.dart';

class FieldsService {
  final FieldsRepository repository;

  const FieldsService({
    required this.repository,
  });

  Future<List<Field>> getFields() async {
    final fields = await repository.getFields();
    return fields.map((field) => Field.fromJson(field)).toList();
  }

  Future<Field> getFieldByUuid(String uuid) async {
    final fields = await repository.getFieldByUuid(uuid);
    if (fields.isEmpty) {
      throw Exception('No field found');
    }

    final field = Field.fromJson(fields.first);
    return field;
  }

  Future<Field> createField(Field field) async {
    final uuid = const Uuid().v1();
    final response = await repository.createField(
      uuid: uuid,
      name: field.name,
      description: field.description,
      price: field.price,
      image: field.image,
    );

    if (response == 0) {
      throw Exception('Failed to create field');
    }

    return field.copyWith(
      uuid: uuid,
    );
  }

  Future<Field> updateField({
    required String uuid,
    String? name,
    String? description,
    String? image,
    double? price,
  }) async {
    final response = await repository.updateField(
      uuid: uuid,
      name: name,
      description: description,
      image: image,
      price: price,
    );

    if (response == 0) {
      throw Exception('Failed to update field');
    }

    return Field(
      uuid: uuid,
      name: name ?? '',
      description: description ?? '',
      image: image ?? '',
      price: price ?? 0,
    );
  }

  Future<int> deleteField(String uuid) async {
    final response = await repository.deleteField(uuid);
    if (response == 0) {
      throw Exception('Failed to delete field');
    }
    return response;
  }
}
