import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationDetailPage extends StatelessWidget {
  final Map<String, dynamic> reservation;

  const ReservationDetailPage({super.key, required this.reservation});

  Future<void> _cancelReservation(BuildContext context) async {
    final reservationId = reservation['id'];
    if (reservationId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('예약 ID가 없어 취소할 수 없습니다.')),
      );
      return;
    }

    // 🔽 예매 취소 확인 다이얼로그
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('예매 취소'),
        content: const Text('정말 이 예매를 취소하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('아니요'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('예, 취소합니다'),
          ),
        ],
      ),
    );

    // 취소 안 하면 종료
    if (confirm != true) return;

    try {
      await FirebaseFirestore.instance
          .collection('reservations')
          .doc(reservationId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('예매가 취소되었습니다.')),
      );
      // ✅ true를 반환하여 목록 페이지가 갱신되도록
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('취소 중 오류 발생: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final reservedAt = reservation['reservedAt'] is Timestamp
        ? (reservation['reservedAt'] as Timestamp).toDate()
        : null;

    // 공연 날짜가 지났는지 확인
    final showDate = DateTime.tryParse(reservation['date']);
    final isPast = showDate != null && showDate.isBefore(DateTime.now());

    return Scaffold(
      appBar: AppBar(title: const Text('예매 상세 정보')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('공연명: ${reservation['showTitle']}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            Text('날짜: ${reservation['date']}'),
            Text('인원 수: ${reservation['people']}명'),
            Text('예매 일시: $reservedAt'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _cancelReservation(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text(isPast ? '취소 불가 (공연 종료)' : '예매 취소'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
