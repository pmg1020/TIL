import 'package:flutter/material.dart';
import '../services/reservation_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ReservationListPage extends StatelessWidget {
  final ReservationService _reservationService = ReservationService();

  ReservationListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('내 예매 내역')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _reservationService.getMyReservations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('오류 발생: ${snapshot.error}'));
          }

          final reservations = snapshot.data!;
          if (reservations.isEmpty) {
            return const Center(child: Text('예매 내역이 없습니다.'));
          }

          return ListView.builder(
            itemCount: reservations.length,
            itemBuilder: (context, index) {
              final res = reservations[index];
              return ListTile(
                leading: const Icon(Icons.confirmation_num),
                title: Text(res['showTitle'] ?? ''),
                subtitle: Text('날짜: ${res['date']} / 인원: ${res['people']}명'),
                trailing: Text((res['reservedAt'] as Timestamp).toDate().toString().substring(0, 10)),
              );
            },
          );
        },
      ),
    );
  }
}
