import 'package:flutter/material.dart';

class ProfileMenuItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isLogout;

  ProfileMenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
    this.isLogout = false,
  });
}
