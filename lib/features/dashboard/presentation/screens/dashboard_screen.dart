// lib/features/dashboard/presentation/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/customer_info_card.dart';
import '../widgets/payment_due_card.dart';
import '../widgets/quick_actions_grid.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1024;

    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: !isDesktop ? const AppDrawer() : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // เพิ่มบรรทัดนี้
        children: [
          if (isDesktop)
            const SizedBox(
              // แก้ไขส่วนนี้
              width: 280, // กำหนดความกว้างที่แน่นอน
              child: AppDrawer(),
            ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome Section
                    Text(
                      'สวัสดี, ${context.read<AuthProvider>().user?.fullName ?? 'คุณลูกค้า'}',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Text(
                      'ยินดีต้อนรับสู่ CPPC B2B Portal',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                    const SizedBox(height: 24),

                    // Info Cards Section
                    // const CustomerInfoCard(),
                    // const SizedBox(height: 16),

                    // Quick Actions Section
                    Row(
                      children: [
                        const Icon(Icons.flash_on, color: Colors.orange),
                        const SizedBox(width: 8),
                        Text(
                          'เมนูลัด',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const QuickActionsGrid(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
          // Right Sidebar for desktop
          if (isDesktop)
            SizedBox(
              // แก้ไขจาก Container เป็น SizedBox
              width: 300,
              child: Card(
                margin: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Notifications section
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const Icon(Icons.notifications_outlined),
                          const SizedBox(width: 8),
                          Text(
                            'การแจ้งเตือน',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    // Notification items will be added here
                    const PaymentDueCard(),
                  ],
                ),
              ),
            ),
        ],
      ),
      floatingActionButton:
          !isDesktop ? _buildFloatingActionButton(context) : null,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('แดชบอร์ด'),
      actions: [
        // Notification Button
        IconButton(
          icon: const Badge(
            label: Text('3'),
            child: Icon(Icons.notifications),
          ),
          onPressed: () {
            // TODO: Show notifications
          },
        ),
        // Profile Menu
        PopupMenuButton(
          offset: const Offset(0, 45),
          icon: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Text(
              context
                      .read<AuthProvider>()
                      .user
                      ?.username
                      .substring(0, 1)
                      .toUpperCase() ??
                  'U',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          itemBuilder: (context) => [
            // Profile Option
            PopupMenuItem(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text('โปรไฟล์'),
                contentPadding: EdgeInsets.zero,
              ),
              onTap: () {
                // TODO: Navigate to profile
              },
            ),
            // Settings Option
            PopupMenuItem(
              child: ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('ตั้งค่า'),
                contentPadding: EdgeInsets.zero,
              ),
              onTap: () {
                // TODO: Navigate to settings
              },
            ),
            // Divider
            const PopupMenuItem(
              height: 1,
              child: Divider(),
            ),
            // Logout Option
            PopupMenuItem(
              child: ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                title: const Text(
                  'ออกจากระบบ',
                  style: TextStyle(color: Colors.red),
                ),
                contentPadding: EdgeInsets.zero,
              ),
              onTap: () async {
                // Delay to allow popup to close
                await Future.delayed(const Duration(milliseconds: 200));
                if (context.mounted) {
                  // Show confirmation dialog
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('ยืนยันการออกจากระบบ'),
                      content: const Text('คุณต้องการออกจากระบบใช่หรือไม่?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('ยกเลิก'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            context.read<AuthProvider>().logout();
                          },
                          child: const Text(
                            'ออกจากระบบ',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        // TODO: Navigate to create order
      },
      icon: const Icon(Icons.add_shopping_cart),
      label: const Text('สั่งซื้อสินค้า'),
    );
  }
}
