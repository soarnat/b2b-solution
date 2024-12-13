// lib/features/dashboard/presentation/widgets/app_drawer.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthProvider>().user;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue, Colors.blue.shade700],
              ),
            ),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo และชื่อ Portal
                const Row(
                  children: [
                    Icon(Icons.business, color: Colors.white, size: 18),
                    SizedBox(width: 6),
                    Text(
                      'CPPC B2B Portal',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // ชื่อบริษัทและปุ่มเลือก
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'บริษัท เอบีซี จำกัด',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'เลือกบริษัท',
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                          Icon(Icons.keyboard_arrow_down,
                              color: Colors.white, size: 14),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // ข้อมูลลูกค้า
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Credit Term
                      Row(
                        children: [
                          Icon(Icons.access_time,
                              color: Colors.white.withOpacity(0.9), size: 12),
                          const SizedBox(width: 4),
                          Text(
                            'เครดิต: N30',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),

                      // ที่อยู่
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on_outlined,
                              color: Colors.white.withOpacity(0.9), size: 12),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '123/45 ถ.พระราม 9 แขวงห้วยขวาง เขตห้วยขวาง กรุงเทพฯ 10310',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 11,
                                height: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),

                      // เบอร์โทร
                      Row(
                        children: [
                          Icon(Icons.phone_outlined,
                              color: Colors.white.withOpacity(0.9), size: 12),
                          const SizedBox(width: 4),
                          Text(
                            '02-123-4567',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // เมนูต่างๆ
          ListTile(
            selected: true,
            leading: const Icon(Icons.dashboard),
            title: const Text('แดชบอร์ด'),
            onTap: () {
              // ถ้าไม่ใช่ desktop mode ให้ปิด drawer
              final isDesktop = MediaQuery.of(context).size.width > 1024;
              if (!isDesktop) {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('สั่งซื้อสินค้า'),
            onTap: () {
              // TODO: Navigate to products
            },
          ),
          ListTile(
            leading: const Icon(Icons.list_alt),
            title: const Text('รายการสั่งซื้อ'),
            onTap: () {
              // TODO: Navigate to orders
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text('ใบกำกับภาษี'),
            onTap: () {
              // TODO: Navigate to invoices
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text('สรุปการซื้อรายปี'),
            onTap: () {
              // TODO: Navigate to invoices
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('ตั้งค่า'),
            onTap: () {
              // TODO: Navigate to settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'ออกจากระบบ',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              context.read<AuthProvider>().logout();
            },
          ),
        ],
      ),
    );
  }
}
