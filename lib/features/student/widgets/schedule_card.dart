import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final String day;
  final String time; // Format dari API/Model biasanya: "08:30 - 09:15"
  final String subject;
  final String teacher;
  final int index;

  const ScheduleCard({
    super.key,
    required this.day,
    required this.time,
    required this.subject,
    required this.teacher,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // Membelah string waktu berdasarkan tanda "-"
    List<String> timeParts = time.split('-');
    String startTime = timeParts.isNotEmpty ? timeParts[0].trim() : time;
    String endTime = timeParts.length > 1 ? timeParts[1].trim() : '';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1950C9), // Biru penuh
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // --- Nomor Urut ---
          SizedBox(
            width: 30, // Sedikit dilebarkan biar angka belasan nggak mepet
            child: Text(
              index.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          // --- Jam Mulai & Selesai (Atas - Bawah) ---
          SizedBox(
            width: 55, // Lebar disesuaikan untuk jam
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  startTime,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.95),
                    fontSize: 14,
                  ),
                ),
                if (endTime.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    endTime,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7), // Sedikit lebih redup biar bergradasi
                      fontSize: 13,
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          const SizedBox(width: 8), // Jarak ekstra antara jam dan nama mapel

          // --- Nama Mapel & Guru ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  teacher,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}