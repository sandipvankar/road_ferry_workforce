import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/order.dart';
import '../../viewmodels/dashboard_view_model.dart';
import '../../widgets/order_card.dart';
import '../auth/login_screen.dart';
import '../profile/faq_screen.dart';
import '../profile/profile_screen.dart';
import '../profile/terms_screen.dart';
import 'add_labour_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardViewModel()..fetchOrders(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          backgroundColor: Colors.deepOrange,
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'profile':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                    break;
                  case 'terms':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermsScreen(),
                      ),
                    );
                    break;
                  case 'faq':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FAQScreen(),
                      ),
                    );
                    break;
                  case 'logout':
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                    break;
                }
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(
                  value: 'profile',
                  child: Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(width: 8),
                      Text('Profile'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'terms',
                  child: Row(
                    children: [
                      Icon(Icons.description),
                      SizedBox(width: 8),
                      Text('Terms & Conditions'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'faq',
                  child: Row(
                    children: [
                      Icon(Icons.help),
                      SizedBox(width: 8),
                      Text('FAQ'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
              ],
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: const [
              Tab(text: 'Active Orders'),
              Tab(text: 'Pending Orders'),
              Tab(text: 'Rejected Orders'),
              Tab(text: 'Completed Orders'),
            ],
          ),
        ),
        body: Consumer<DashboardViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return TabBarView(
              controller: _tabController,
              children: [
                _buildOrderList(viewModel.activeOrders, true),
                _buildOrderList(viewModel.pendingOrders, true),
                _buildOrderList(viewModel.rejectedOrders, true),
                _buildOrderList(viewModel.completedOrders, false),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddLabourScreen()),
            );
          },
          backgroundColor: Colors.deepOrange,
          icon: const Icon(Icons.person_add),
          label: const Text('Add Labour'),
        ),
      ),
    );
  }

  Widget _buildOrderList(List<Order> orders, bool showDetails) {
    if (orders.isEmpty) {
      return const Center(child: Text('No orders found'));
    }

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderCard(
          order: order,
          showDetails: showDetails,
          onLocationTap: () {
            // TODO: Open map with location pin
          },
          onStatusUpdate: () async {
            if (order.status != OrderStatus.completed) {
              final viewModel = context.read<DashboardViewModel>();

              // Show OTP dialog for status changes
              final otp = await _showOtpDialog();
              if (otp != null) {
                final verified = await viewModel.verifyOtp(order.id, otp);
                if (verified) {
                  final newStatus = order.status == OrderStatus.arrived
                      ? OrderStatus.inProgress
                      : OrderStatus.completed;
                  await viewModel.updateOrderStatus(order.id, newStatus);
                }
              }
            }
          },
        );
      },
    );
  }

  Future<String?> _showOtpDialog() async {
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter OTP'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'Enter the OTP'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Verify'),
          ),
        ],
      ),
    );
    controller.dispose();
    return result;
  }
}
