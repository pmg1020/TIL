import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReservationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 예매 저장
  Future<void> reserve({
    required String showId,
    required String showTitle,
    required String date,
    required int people,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("로그인된 사용자가 없습니다.");

    await _firestore.collection('reservations').add({
      'userId': user.uid,
      'showId': showId,
      'showTitle': showTitle,
      'date': date,
      'people': people,
      'reservedAt': FieldValue.serverTimestamp(),
    });
  }

  // 예매 조회
  Future<List<Map<String, dynamic>>> getMyReservations() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('로그인이 필요합니다.');

    final snapshot = await _firestore
        .collection('reservations')
        .where('userId', isEqualTo: user.uid)
        .orderBy('reservedAt', descending: true)
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
