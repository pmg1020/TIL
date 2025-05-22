import 'package:flutter/material.dart';
import '../models/show.dart';
import 'reserve_page.dart'; // 예매 페이지 import

class ShowDetailPage extends StatelessWidget {
  final Show show;

  const ShowDetailPage({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(show.title)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.event, size: 80, color: Colors.blueAccent),
            const SizedBox(height: 24),
            Text(
              show.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text('유형: ${show.type}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('장소: ${show.location}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              '날짜: ${show.date.join(', ')}', // 여러 날짜를 쉼표로 구분해 보여줌
              style: const TextStyle(fontSize: 18),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReservePage(show: show),
                    ),
                  );
                },
                child: const Text('예매하기'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
