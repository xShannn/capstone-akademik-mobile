import 'package:flutter/material.dart';

class RiwayatPresensiPage extends StatelessWidget {
  RiwayatPresensiPage({super.key});

  // Data dummy riwayat presensi
  final List<Map<String, String>> _riwayat = [
    {
      'subject': 'Matematika',
      'topic': 'Trigonometri',
      'time': '07.15 - 08.15',
      'date': '5 Mei 2026',
      'status': 'Hadir',
    },
    {
      'subject': 'Fisika',
      'topic': 'Hukum Newton',
      'time': '08.15 - 09.15',
      'date': '4 Mei 2026',
      'status': 'Hadir',
    },
    {
      'subject': 'B. Indonesia',
      'topic': 'Teks Eksposisi',
      'time': '09.15 - 10.15',
      'date': '3 Mei 2026',
      'status': 'Izin',
    },
    {
      'subject': 'Kimia',
      'topic': 'Ikatan Kimia',
      'time': '11.30 - 12.30',
      'date': '2 Mei 2026',
      'status': 'Absen',
    },
    {
      'subject': 'Sejarah',
      'topic': 'Masa Kolonial',
      'time': '13.00 - 14.00',
      'date': '1 Mei 2026',
      'status': 'Hadir',
    },
    {
      'subject': 'Agama',
      'topic': 'Akhlak Terpuji',
      'time': '07.15 - 08.15',
      'date': '30 Apr 2026',
      'status': 'Hadir',
    },
    {
      'subject': 'Matematika',
      'topic': 'Matriks',
      'time': '08.15 - 09.15',
      'date': '29 Apr 2026',
      'status': 'Hadir',
    },
  ];

  // Fungsi untuk menentukan warna background berdasarkan status
  Color _getBgColor(String status) {
    switch (status) {
      case 'Hadir':
        return const Color(0xFFDCFCE7); // Hijau muda
      case 'Absen':
        return const Color(0xFFFEE2E2); // Merah muda
      case 'Izin':
        return const Color(0xFFFEF9C3); // Kuning muda
      default:
        return Colors.grey.shade200;
    }
  }

  // Fungsi untuk menentukan warna teks berdasarkan status
  Color _getTextColor(String status) {
    switch (status) {
      case 'Hadir':
        return const Color(0xFF166534); // Hijau tua
      case 'Absen':
        return const Color(0xFF991B1B); // Merah tua
      case 'Izin':
        return const Color(0xFF854D0E); // Kuning/Coklat tua
      default:
        return Colors.black87;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F42B3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Riwayat Presensi',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          // --- KETERANGAN WARNA (LEGEND) ---
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            color: const Color(0xFFF8F9FE),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Menambahkan parameter warna fill yang senada dengan background card
                _buildLegendItem(
                  'Hadir',
                  const Color(0xFF166534),
                  const Color(0xFFDCFCE7),
                ),
                const SizedBox(width: 24),
                _buildLegendItem(
                  'Absen',
                  const Color(0xFF991B1B),
                  const Color(0xFFFEE2E2),
                ),
                const SizedBox(width: 24),
                _buildLegendItem(
                  'Izin',
                  const Color(0xFF854D0E),
                  const Color(0xFFFEF9C3),
                ),
              ],
            ),
          ),

          // --- LIST RIWAYAT ---
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              itemCount: _riwayat.length,
              itemBuilder: (context, index) {
                final data = _riwayat[index];
                final bgColor = _getBgColor(data['status']!);
                final textColor = _getTextColor(data['status']!);

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bagian Kiri (Mata Pelajaran, Topik, Waktu)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['subject']!,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            data['topic']!,
                            style: TextStyle(color: textColor, fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            data['time']!,
                            style: TextStyle(color: textColor, fontSize: 12),
                          ),
                        ],
                      ),

                      // Bagian Kanan (Tanggal)
                      Text(
                        data['date']!,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget kecil untuk kotak keterangan di atas
  // Widget kecil untuk kotak keterangan di atas (Sudah ditambah parameter fillColor)
  Widget _buildLegendItem(String label, Color borderColor, Color fillColor) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: fillColor, // <-- Sekarang warna fill-nya sudah terisi
            border: Border.all(color: borderColor, width: 1.5),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF1A1A24),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
