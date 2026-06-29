import 'package:flutter/material.dart';

class AdminBottomNavbar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const AdminBottomNavbar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTap,
      backgroundColor: const Color(0xFFFFFFFF),
      selectedItemColor: const Color(0xFF093FB4),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.manage_accounts),
          label: 'Manage',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Report'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
