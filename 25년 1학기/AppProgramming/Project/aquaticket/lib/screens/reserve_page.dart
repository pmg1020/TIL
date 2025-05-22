import 'package:flutter/material.dart';
import '../models/show.dart';
import '../services/reservation_service.dart';

class ReservePage extends StatefulWidget {
  final Show show;

  const ReservePage({super.key, required this.show});

  @override
  State<ReservePage> createState() => _ReservePageState();
}

class _ReservePageState extends State<ReservePage> {
  int _selectedPeople = 1;
  String? _selectedDate;

  @override
  void initState() {
    super.initState();
    // 날짜가 1개면 자동 선택
    if (widget.show.date.length == 1) {
      _selectedDate = widget.show.date.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.show.title} 예매')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('공연: ${widget.show.title}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),

            // 날짜 선택
            widget.show.date.length == 1
                ? Text('날짜: ${widget.show.date.first}', style: const TextStyle(fontSize: 16))
                : DropdownButtonFormField<String>(
              value: _selectedDate,
              hint: const Text('날짜 선택'),
              items: widget.show.date.map((date) {
                return DropdownMenuItem(value: date, child: Text(date));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDate = value;
                });
              },
            ),

            const SizedBox(height: 20),

            // 인원 선택
            Row(
              children: [
                const Text('인원 수:', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 20),
                DropdownButton<int>(
                  value: _selectedPeople,
                  items: List.generate(10, (i) => i + 1)
                      .map((num) => DropdownMenuItem(value: num, child: Text('$num명')))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPeople = value!;
                    });
                  },
                ),
              ],
            ),

            const Spacer(),

            // 예매 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedDate == null
                    ? null
                    : () async {
                  try {
                    await ReservationService().reserve(
                      showId: widget.show.id,
                      showTitle: widget.show.title,
                      date: _selectedDate!,
                      people: _selectedPeople,
                    );

                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('예매 완료'),
                        content: Text(
                          '${widget.show.title} 공연\n날짜: $_selectedDate / 인원: $_selectedPeople명',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('확인'),
                          ),
                        ],
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('예매 실패: $e')),
                    );
                  }
                },
                child: const Text('예매 확정'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
