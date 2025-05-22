import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/show.dart';

class ShowService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Show>> getShows() async {
    final snapshot = await _firestore.collection('shows').get();
    return snapshot.docs.map((doc) => Show.fromMap(doc.id, doc.data())).toList();
  }
}
