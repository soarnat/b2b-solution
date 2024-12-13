// lib/features/dashboard/domain/entities/dashboard_stats_backup.dart
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class DashboardStats extends Equatable {
  final Company company;
  final DueDateAlert? dueDateAlert;
  final List<QuickAction> quickActions;
  final SalesStats salesStats;
  final List<Order> recentOrders;
  final int notificationCount;

  const DashboardStats({
    required this.company,
    this.dueDateAlert,
    required this.quickActions,
    required this.salesStats,
    required this.recentOrders,
    this.notificationCount = 0,
  });

  @override
  List<Object?> get props => [
        company,
        dueDateAlert,
        quickActions,
        salesStats,
        recentOrders,
        notificationCount,
      ];
}

class Company extends Equatable {
  final String name;
  final String code;
  final String creditTerm;
  final String customerType;
  final String address;
  final String phone;

  const Company({
    required this.name,
    required this.code,
    required this.creditTerm,
    required this.customerType,
    required this.address,
    required this.phone,
  });

  @override
  List<Object> get props => [
        name,
        code,
        creditTerm,
        customerType,
        address,
        phone,
      ];
}

class QuickAction extends Equatable {
  final String title;
  final int count;
  final IconData icon;
  final Color color;
  final String? route;

  const QuickAction({
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
    this.route,
  });

  @override
  List<Object?> get props => [title, count, icon, color, route];
}

class SalesStats extends Equatable {
  final List<MonthlySales> monthlySales;
  final double totalSales;
  final double targetSales;
  final int year;

  const SalesStats({
    required this.monthlySales,
    required this.totalSales,
    required this.targetSales,
    required this.year,
  });

  @override
  List<Object> get props => [monthlySales, totalSales, targetSales, year];
}

class MonthlySales extends Equatable {
  final String month;
  final double amount;
  final int orderCount;

  const MonthlySales({
    required this.month,
    required this.amount,
    required this.orderCount,
  });

  @override
  List<Object> get props => [month, amount, orderCount];
}

class Order extends Equatable {
  final String code;
  final DateTime date;
  final double amount;
  final OrderStatus status;
  final DateTime dueDate;
  final String? remark;

  const Order({
    required this.code,
    required this.date,
    required this.amount,
    required this.status,
    required this.dueDate,
    this.remark,
  });

  @override
  List<Object?> get props => [
        code,
        date,
        amount,
        status,
        dueDate,
        remark,
      ];
}

class DueDateAlert extends Equatable {
  final String orderCode;
  final DateTime dueDate;
  final double amount;
  final int daysRemaining;

  const DueDateAlert({
    required this.orderCode,
    required this.dueDate,
    required this.amount,
    required this.daysRemaining,
  });

  @override
  List<Object> get props => [orderCode, dueDate, amount, daysRemaining];
}

enum OrderStatus {
  pending,
  processing,
  shipping,
  delivered,
  cancelled;

  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'รอดำเนินการ';
      case OrderStatus.processing:
        return 'กำลังดำเนินการ';
      case OrderStatus.shipping:
        return 'กำลังจัดส่ง';
      case OrderStatus.delivered:
        return 'จัดส่งแล้ว';
      case OrderStatus.cancelled:
        return 'ยกเลิก';
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.processing:
        return Colors.blue;
      case OrderStatus.shipping:
        return Colors.purple;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }
}
