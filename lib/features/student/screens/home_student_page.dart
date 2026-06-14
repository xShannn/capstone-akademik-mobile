import 'package:flutter/material.dart';
import 'package:mobile_sekolah/features/student/screens/presensi_page.dart';

class HomeStudentPage extends StatefulWidget {
  // Menangkap fungsi dari Main Page
  final Function(int)? onTabChange;

  final List<Map<String, dynamic>> tasks;

  const HomeStudentPage({super.key, this.onTabChange, required this.tasks});

  @override
  State<HomeStudentPage> createState() => _HomeStudentPageState();
}

class _HomeStudentPageState extends State<HomeStudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildClassAndAttendanceCard(),
                  const SizedBox(height: 20),
                  _buildGradesOverviewCard(),
                  const SizedBox(height: 20),
                  _buildUpcomingTasksCard(),
                  const SizedBox(height: 20),
                  _buildScheduleTable(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 24),
      decoration: const BoxDecoration(color: Color(0xFF0F42B3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good morning,',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              SizedBox(height: 4),
              Text(
                'Mas Akhlis K.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Stack(
                  children: [
                    Icon(Icons.notifications_outlined, color: Colors.white),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white38),
                ),
                child: const Center(
                  child: Text(
                    'AK',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClassAndAttendanceCard() {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman Presensi saat diklik
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PresensiPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0F42B3), Color(0xFF2E65E5)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today, 30 April 2026',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                SizedBox(height: 4),
                Text(
                  'Class X IPA 1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Attendance: 92%',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(color: Colors.white38, width: 2),
              ),
              child: const Column(
                children: [
                  Icon(Icons.qr_code_scanner, color: Colors.white, size: 28),
                  SizedBox(height: 4),
                  Text(
                    'Presensi',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F42B3), Color(0xFF2E65E5)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Today, 30 April 2026',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              SizedBox(height: 4),
              Text(
                'Class X IPA 1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Attendance: 92%',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(color: Colors.white38, width: 2),
            ),
            child: const Column(
              children: [
                Icon(Icons.qr_code_scanner, color: Colors.white, size: 28),
                SizedBox(height: 4),
                Text(
                  'Presensi',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- BAGIAN INI UNTUK PANAH SEE MORE ---
  Widget _buildGradesOverviewCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Grades Overview',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A24),
                ),
              ),
              // Tombol Panah untuk See More
              GestureDetector(
                onTap: () {
                  // Memanggil fungsi untuk geser ke Grade (Index 1)
                  if (widget.onTabChange != null) {
                    widget.onTabChange!(1);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(0, 248, 249, 254),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Color.fromARGB(255, 26, 26, 46),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildGradeItem('Matematika', 88, const Color(0xFF0F42B3)),
          const SizedBox(height: 12),
          _buildGradeItem('Fisika', 75, Colors.redAccent),
          const SizedBox(height: 12),
          _buildGradeItem('B. Indonesia', 92, const Color(0xFF0F42B3)),
          const SizedBox(height: 12),
          _buildGradeItem('Kimia', 80, const Color(0xFF0F42B3)),
        ],
      ),
    );
  }

  Widget _buildGradeItem(String subject, int score, Color barColor) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            subject,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: LinearProgressIndicator(
            value: score / 100,
            backgroundColor: Colors.grey.shade200,
            color: barColor,
            minHeight: 6,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          '$score',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildUpcomingTasksCard() {
    // Memfilter tugas: Ambil yang isDone-nya false (Pending), lalu ambil maksimal 3 saja
    final pendingTasks = widget.tasks
        .where((task) => task['isDone'] == false)
        .take(3)
        .toList();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Upcoming Tasks',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A24),
                ),
              ),
              // Tombol Panah untuk See More
              GestureDetector(
                onTap: () {
                  // Memanggil fungsi untuk geser ke Task (Index 2)
                  if (widget.onTabChange != null) {
                    widget.onTabChange!(2);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Color.fromARGB(255, 26, 26, 46),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Me-loop data 3 tugas teratas untuk ditampilkan
          if (pendingTasks.isNotEmpty)
            ...pendingTasks.map((task) {
              return Column(
                children: [
                  _buildTaskItem(
                    task['title'] as String,
                    'Due: ${task['due']}',
                    'Pending', // Karena yang difilter hanya yang isDone == false
                    Colors.orange,
                    const Color(0xFFFEF3E1),
                  ),
                  // Menambahkan garis batas (Divider) kecuali pada item terakhir
                  if (task != pendingTasks.last)
                    const Divider(
                      height: 24,
                      thickness: 1,
                      color: Color(0xFFF0F0F0),
                    ),
                ],
              );
            }).toList()
          else
            // Jika tidak ada tugas pending
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Engga ada tugas kok tenang aaa',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(
    String title,
    String dueDate,
    String status,
    Color statusColor,
    Color statusBg,
  ) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: status == 'Done'
                ? const Color(0xFF0F42B3)
                : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              Text(
                dueDate,
                style: const TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: statusBg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: statusColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF0F42B3),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'TIME',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
                Text(
                  'MON',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
                Text(
                  'TUE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
                Text(
                  'WE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
                Text(
                  'TH',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
                Text(
                  'FRI',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          // Table Rows dengan jadwal yang sudah divariasikan untuk anak IPA
          _buildScheduleRow(
            '07:15',
            'MAT',
            'Fisika',
            'Kimia',
            'Biologi',
            'Agama',
          ),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),

          _buildScheduleRow(
            '08:15',
            'MAT',
            'Fisika',
            'Kimia',
            'Biologi',
            'Agama',
          ),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),

          _buildScheduleRow('09:15', 'B.Ing', 'PKN', 'MAT', 'Sejarah', 'B.Ind'),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),

          _buildScheduleRow('11:30', 'B.Ing', 'PKN', 'MAT', 'Sejarah', 'B.Ind'),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),

          _buildScheduleRow('13:00', 'SBK', 'PJOK', 'TIK', 'PKWU', 'BK'),
        ],
      ),
    );
  }

  Widget _buildScheduleRow(
    String time,
    String mon,
    String tue,
    String we,
    String th,
    String fri,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 40,
            child: Text(
              time,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(
              mon,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, color: Colors.black87),
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(
              tue,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, color: Colors.black87),
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(
              we,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, color: Colors.black87),
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(
              th,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, color: Colors.black87),
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(
              fri,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
