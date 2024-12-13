// lib/features/orders/domain/enums/order_enums.dart
import 'package:flutter/material.dart';

enum OrderStatus {
  draft('ร่าง', 'สินค้าในตะกร้า'),
  pendingPayment('รอชำระเงิน', 'รอการชำระเงิน'),
  pendingConfirmation('รอยืนยันการผลิต', 'รอยืนยันการผลิต'),
  inProduction('กำลังผลิต', 'อยู่ระหว่างการผลิต'),
  readyToShip('รอจัดส่ง', 'สินค้าพร้อมจัดส่ง'),
  shipping('กำลังนำส่ง', 'อยู่ระหว่างการจัดส่ง'),
  delivered('รับสินค้าแล้ว', 'จัดส่งเรียบร้อย'),
  cancelled('ยกเลิก', 'คำสั่งซื้อถูกยกเลิก');

  final String display;
  final String description;

  const OrderStatus(this.display, this.description);

  // Getters for checking status
  bool get isDraft => this == OrderStatus.draft;
  bool get isPendingPayment => this == OrderStatus.pendingPayment;
  bool get isPendingConfirmation => this == OrderStatus.pendingConfirmation;
  bool get isInProduction => this == OrderStatus.inProduction;
  bool get isReadyToShip => this == OrderStatus.readyToShip;
  bool get isShipping => this == OrderStatus.shipping;
  bool get isDelivered => this == OrderStatus.delivered;
  bool get isCancelled => this == OrderStatus.cancelled;

  // Business logic checks
  bool get canCancel => [
        OrderStatus.draft,
        OrderStatus.pendingPayment,
        OrderStatus.pendingConfirmation,
      ].contains(this);

  bool get canEdit => [
        OrderStatus.draft,
        OrderStatus.pendingPayment,
      ].contains(this);

  bool get requiresPayment => this == OrderStatus.pendingPayment;

  bool get isCompleted => [
        OrderStatus.delivered,
        OrderStatus.cancelled,
      ].contains(this);

  bool get isInProgress => [
        OrderStatus.inProduction,
        OrderStatus.readyToShip,
        OrderStatus.shipping,
      ].contains(this);

  bool get needsAction => [
        OrderStatus.pendingPayment,
        OrderStatus.pendingConfirmation,
      ].contains(this);

  // UI properties
  Color get color {
    switch (this) {
      case OrderStatus.draft:
        return Colors.grey;
      case OrderStatus.pendingPayment:
        return Colors.orange;
      case OrderStatus.pendingConfirmation:
        return Colors.blue;
      case OrderStatus.inProduction:
        return Colors.purple;
      case OrderStatus.readyToShip:
        return Colors.indigo;
      case OrderStatus.shipping:
        return Colors.cyan;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }

  IconData get icon {
    switch (this) {
      case OrderStatus.draft:
        return Icons.shopping_cart_outlined;
      case OrderStatus.pendingPayment:
        return Icons.payment_outlined;
      case OrderStatus.pendingConfirmation:
        return Icons.pending_actions_outlined;
      case OrderStatus.inProduction:
        return Icons.precision_manufacturing_outlined;
      case OrderStatus.readyToShip:
        return Icons.inventory_2_outlined;
      case OrderStatus.shipping:
        return Icons.local_shipping_outlined;
      case OrderStatus.delivered:
        return Icons.check_circle_outline;
      case OrderStatus.cancelled:
        return Icons.cancel_outlined;
    }
  }

  // Next possible statuses
  List<OrderStatus> get nextPossibleStatuses {
    switch (this) {
      case OrderStatus.draft:
        return [OrderStatus.pendingPayment, OrderStatus.cancelled];
      case OrderStatus.pendingPayment:
        return [OrderStatus.pendingConfirmation, OrderStatus.cancelled];
      case OrderStatus.pendingConfirmation:
        return [OrderStatus.inProduction, OrderStatus.cancelled];
      case OrderStatus.inProduction:
        return [OrderStatus.readyToShip];
      case OrderStatus.readyToShip:
        return [OrderStatus.shipping];
      case OrderStatus.shipping:
        return [OrderStatus.delivered];
      case OrderStatus.delivered:
      case OrderStatus.cancelled:
        return [];
    }
  }

  // Help text for status
  String get helpText {
    switch (this) {
      case OrderStatus.draft:
        return 'คำสั่งซื้อที่ยังไม่ได้ยืนยัน';
      case OrderStatus.pendingPayment:
        return 'รอการชำระเงินจากลูกค้า';
      case OrderStatus.pendingConfirmation:
        return 'รอการยืนยันการผลิตจากฝ่ายผลิต';
      case OrderStatus.inProduction:
        return 'อยู่ในขั้นตอนการผลิต';
      case OrderStatus.readyToShip:
        return 'สินค้าพร้อมจัดส่ง รอเจ้าหน้าที่ดำเนินการ';
      case OrderStatus.shipping:
        return 'อยู่ระหว่างการจัดส่งไปยังลูกค้า';
      case OrderStatus.delivered:
        return 'จัดส่งถึงลูกค้าเรียบร้อยแล้ว';
      case OrderStatus.cancelled:
        return 'คำสั่งซื้อถูกยกเลิก';
    }
  }
}

// Extension methods
extension OrderStatusX on String {
  OrderStatus? toOrderStatus() {
    try {
      return OrderStatus.values.firstWhere(
        (status) => status.name.toLowerCase() == toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }
}

// Helper for order status filters
class OrderStatusHelper {
  static List<OrderStatus> getActiveStatuses() {
    return OrderStatus.values.where((status) => !status.isCompleted).toList();
  }

  static List<OrderStatus> getCompletedStatuses() {
    return OrderStatus.values.where((status) => status.isCompleted).toList();
  }

  static List<OrderStatus> getActionRequiredStatuses() {
    return OrderStatus.values.where((status) => status.needsAction).toList();
  }
}

// เพิ่ม enums ที่เกี่ยวข้องกับ Order
enum OrderType {
  regular('สั่งซื้อปกติ'),
  preOrder('สั่งจองล่วงหน้า'),
  special('สั่งพิเศษ');

  final String display;
  const OrderType(this.display);
}

enum ShippingMethod {
  pickup('รับที่บริษัท'),
  company('รถบริษัท'),
  courier('ขนส่งเอกชน');

  final String display;
  const ShippingMethod(this.display);
}

enum OrderPriority {
  normal('ปกติ'),
  urgent('ด่วน'),
  veryUrgent('ด่วนมาก');

  final String display;
  const OrderPriority(this.display);
}
