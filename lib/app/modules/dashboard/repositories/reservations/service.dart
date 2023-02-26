import 'package:fields/app/models/reservation.dart';
import 'package:fields/app/modules/dashboard/repositories/reservations/repository.dart';
import 'package:uuid/uuid.dart';

class ReservationsService {
  final ReservationsRepository repository;

  const ReservationsService({
    required this.repository,
  });

  Future<List<Reservation>> getReservations() async {
    final reservations = await repository.getReservations();
    return reservations
        .map((reservation) => Reservation.fromJson(reservation))
        .toList();
  }

  Future<Reservation> getReservationByUuid(String uuid) async {
    final reservations = await repository.getReservationByUuid(uuid);
    if (reservations.isEmpty) {
      throw Exception('No reservation found');
    }
    final reservation = Reservation.fromJson(reservations.first);
    return reservation;
  }

  Future<Reservation> createReservation(Reservation reservation) async {
    final uuid = const Uuid().v1();
    final response = await repository.createReservation(
      uuid,
      reservation.userName,
      reservation.fieldUuid,
      reservation.date,
    );

    if (response == 0) {
      throw Exception('Failed to create reservation');
    }

    return reservation.copyWith(
      uuid: uuid,
    );
  }

  Future<Reservation> updateReservation({
    required String uuid,
    String? userName,
    String? fieldUuid,
    DateTime? date,
  }) async {
    final response = await repository.updateReservation(
      uuid: uuid,
      userName: userName,
      fieldUuid: fieldUuid,
      date: date,
    );

    if (response == 0) {
      throw Exception('Failed to update reservation');
    }

    final reservation = await getReservationByUuid(uuid);

    return reservation;
  }

  Future<void> deleteReservation(String uuid) async {
    final response = await repository.deleteReservation(uuid);

    if (response == 0) {
      throw Exception('No reservation deleted');
    }
  }
}
