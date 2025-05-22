class Show {
  final String id;
  final String title;
  final String type;
  final String location;
  final List<String> date; // ✅ 문자열 배열로 변경

  Show({
    required this.id,
    required this.title,
    required this.type,
    required this.location,
    required this.date,
  });

  factory Show.fromMap(String id, Map<String, dynamic> data) {
    return Show(
      id: id,
      title: data['title'] ?? '',
      type: data['type'] ?? '',
      location: data['location'] ?? '',
      date: List<String>.from(data['date'] ?? []), // ✅ 여기 중요!
    );
  }
}
