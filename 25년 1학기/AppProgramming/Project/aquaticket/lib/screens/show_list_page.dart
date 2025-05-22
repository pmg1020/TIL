import 'package:flutter/material.dart';
import '../models/show.dart';
import '../services/show_service.dart';
import 'show_detail_page.dart';

class ShowListPage extends StatefulWidget {
  const ShowListPage({super.key});

  @override
  State<ShowListPage> createState() => _ShowListPageState();
}

class _ShowListPageState extends State<ShowListPage> {
  late Future<List<Show>> _showsFuture;

  @override
  void initState() {
    super.initState();
    _showsFuture = ShowService().getShows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('공연 목록')),
      body: FutureBuilder<List<Show>>(
        future: _showsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('에러 발생: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('공연 정보가 없습니다.'));
          }

          final shows = snapshot.data!;
          return ListView.builder(
            itemCount: shows.length,
            itemBuilder: (context, index) {
              final show = shows[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(Icons.event),
                  title: Text(
                    show.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text('${show.type} | ${show.location}'),
                  trailing: Text(show.date.isNotEmpty ? show.date[0] : '날짜 없음'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowDetailPage(show: show), // 🔥 상세페이지로 이동
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
