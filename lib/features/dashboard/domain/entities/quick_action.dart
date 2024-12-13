// lib/features/dashboard/domain/entities/quick_action.dart
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class QuickAction extends Equatable {
  final String title;
  final String route;
  final int count;
  final IconData icon;
  final Color color;

  const QuickAction({
    required this.title,
    required this.route,
    required this.count,
    required this.icon,
    required this.color,
  });

  @override
  List<Object> get props => [title, route, count, icon, color];
}
