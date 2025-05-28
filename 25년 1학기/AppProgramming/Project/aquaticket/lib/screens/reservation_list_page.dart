import 'package:flutter/material.dart';
import '../services/reservation_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'reservation_detail_page.dart';

class ReservationListPage extends StatefulWidget {
  const ReservationListPage({super.key});

  @override
  State<ReservationListPage> createState() => _ReservationListPageState();
}

class _ReservationListPageState extends State<ReservationListPage> {
  final ReservationService _reservationService = ReservationService();
  late Future<List<Map<String, dynamic>>> _reservationsFuture;

  @override
  void initState() {
    super.initState();
    _loadReservations();
  }

  void _loadReservations() {
    _reservationsFuture = _reservationService.getMyReservations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('내 예매 내역')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _reservationsFuture,
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
                onTap: () async {
                  // ✅ 상세 페이지로 이동하고 결과 받기
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReservationDetailPage(reservation: res),
                    ),
                  );

                  // ✅ 취소 후 true 반환되면 목록 다시 불러오기
                  if (result == true) {
                    setState(() {
                      _loadReservations();
                    });
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
