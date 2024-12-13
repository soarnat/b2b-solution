// lib/features/dashboard/presentation/widgets/quick_actions_grid.dart
import 'package:flutter/material.dart';

class QuickActionItem {
  final String title;
  final int count;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const QuickActionItem({
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
    this.onTap,
  });
}

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  List<QuickActionItem> get _items => [
        QuickActionItem(
          title: 'สินค้าทั้งหมด',
          count: 20,
          icon: Icons.inventory_2,
          color: Colors.green,
          onTap: () {
            // TODO: Navigate to products
          },
        ),
        QuickActionItem(
          title: 'ค้างชำระ',
          count: 3,
          icon: Icons.receipt_long,
          color: Colors.purple,
          onTap: () {
            // TODO: Navigate to invoices
          },
        ),
        QuickActionItem(
          title: 'ติดต่อเจ้าหน้าที่',
          count: 0,
          icon: Icons.headset_mic,
          color: Colors.teal,
          onTap: () {
            // TODO: Navigate to support
          },
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1024;
    final crossAxisCount = isDesktop ? 5 : (screenWidth > 600 ? 3 : 2);

    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: isDesktop ? 1.5 : 1.2,
          ),
          itemCount: _items.length,
          itemBuilder: (context, index) {
            final item = _items[index];
            return _QuickActionCard(item: item);
          },
        );
      },
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final QuickActionItem item;

  const _QuickActionCard({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  item.icon,
                  color: item.color,
                  size: 28,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                item.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              if (item.count > 0) ...[
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: item.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${item.count} รายการ',
                    style: TextStyle(
                      fontSize: 12,
                      color: item.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
