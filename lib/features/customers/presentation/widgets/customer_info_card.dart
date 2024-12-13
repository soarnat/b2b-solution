// lib/features/customers/presentation/widgets/customer_info_card.dart
import 'package:flutter/material.dart';
import '../../domain/entities/customer.dart';
import '../../domain/entities/payment_term.dart';
import '../../domain/entities/address.dart';

class CustomerInfoCard extends StatelessWidget {
  final Customer customer;

  const CustomerInfoCard({
    super.key,
    required this.customer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer Header
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customer.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'รหัสลูกค้า: ${customer.code}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ),
                _buildPaymentTermBadge(customer.paymentTerm),
              ],
            ),
            const Divider(height: 24),

            // Contact Info
            _buildInfoRow(
              context,
              icon: Icons.email_outlined,
              label: 'อีเมล',
              value: customer.email,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              context,
              icon: Icons.phone_outlined,
              label: 'โทรศัพท์',
              value: customer.phone,
            ),
            if (customer.taxId != null) ...[
              const SizedBox(height: 8),
              _buildInfoRow(
                context,
                icon: Icons.business_outlined,
                label: 'เลขประจำตัวผู้เสียภาษี',
                value: customer.taxId!,
              ),
            ],
            const Divider(height: 24),

            // Address
            if (customer.defaultAddress != null) ...[
              Text(
                'ที่อยู่',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Text(
                _formatAddress(customer.defaultAddress!, separator: ', '),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentTermBadge(PaymentTerm paymentTerm) {
    final isCredit = paymentTerm.isCredit;
    final color = isCredit ? Colors.blue : Colors.green;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        paymentTerm.display,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            Text(value),
          ],
        ),
      ],
    );
  }

  String _formatAddress(Address address, {String separator = ' '}) {
    return [
      address.address,
      address.subDistrict,
      address.district,
      address.province,
      address.postalCode,
    ]
        .where((part) => part.isNotEmpty)
        .join(separator); // ปรับปรุงให้ handle empty string ด้วย
  }
}
