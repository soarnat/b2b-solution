// lib/core/constants/enum_constants.dart
enum AuthStatus {
  initial,
  authenticating,
  authenticated,
  unauthenticated,
  error
}

//enum OrderStatus { draft, pending, processing, shipped, delivered, cancelled }
//เลือกสินค้าแต่ยังไม่สั่งซื้อ, รอชำระเงิน, รอยืนยันการผลิต, กำลังผลิต, รอจัดส่ง, กำลังนำส่ง, ยกเลิก, ประวัติคำสั่งซื้อ

enum PaymentStatus { pending, paid, overdue, cancelled }

enum ThemeMode { light, dark, system }
