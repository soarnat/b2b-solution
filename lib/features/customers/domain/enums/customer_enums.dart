// 1. สร้าง enums ก่อน (lib/features/customers/domain/enums/customer_enums.dart)
enum CustomerType {
  cod('เงินสด', 'COD'),
  credit('เครดิต', 'Credit');

  final String display;
  final String code;

  const CustomerType(this.display, this.code);

  bool get isCOD => this == CustomerType.cod;
  bool get isCredit => this == CustomerType.credit;
}

enum CustomerStatus {
  active('ใช้งาน'),
  inactive('ระงับการใช้งาน');

  final String display;
  const CustomerStatus(this.display);
}
