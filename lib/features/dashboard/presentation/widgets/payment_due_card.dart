// lib/features/dashboard/presentation/widgets/payment_due_card.dart
import 'package:flutter/material.dart';
import '../../../../core/utils/number_utils.dart';
import '../../../../core/utils/date_utils.dart';

class PaymentDueCard extends StatelessWidget {
  final bool isOverdue;

  const PaymentDueCard({
    super.key,
    this.isOverdue = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isOverdue ? Colors.red.shade50 : Colors.orange.shade50,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  isOverdue ? Icons.warning : Icons.access_time,
                  color: isOverdue ? Colors.red : Colors.orange,
                ),
                const SizedBox(width: 8),
                Text(
                  isOverdue ? 'รายการค้างชำระ' : 'รายการที่ใกล้ครบกำหนดชำระ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isOverdue ? Colors.red : Colors.orange.shade700,
                  ),
                ),
              ],
            ),
          ),
          const _DuePaymentItem(
            invoiceNo: 'INV-2024001',
            dueDate: '3/11/2024',
            amount: 25000,
            daysRemaining: 5,
          ),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'ดูทั้งหมด',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DuePaymentItem extends StatelessWidget {
  final String invoiceNo;
  final String dueDate;
  final double amount;
  final int daysRemaining;

  const _DuePaymentItem({
    required this.invoiceNo,
    required this.dueDate,
    required this.amount,
    required this.daysRemaining,
  });

  @override
  Widget build(BuildContext context) {
    final isOverdue = daysRemaining < 0;
    final textColor = isOverdue ? Colors.red : Colors.orange.shade700;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'เลขที่',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      invoiceNo,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'วันครบกำหนด',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dueDate,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'จำนวนเงิน',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppNumberUtils.toCurrency(amount),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: isOverdue ? Colors.red.shade50 : Colors.orange.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              isOverdue
                  ? 'เลยกำหนดชำระ ${-daysRemaining} วัน'
                  : 'เหลือเวลาอีก $daysRemaining วัน',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
