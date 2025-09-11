import 'package:flutter/material.dart';
import '../../models/order.dart';

class AddLabourScreen extends StatefulWidget {
  const AddLabourScreen({super.key});

  @override
  State<AddLabourScreen> createState() => _AddLabourScreenState();
}

class _AddLabourScreenState extends State<AddLabourScreen> {
  int _availableLabourers = 10; // TODO: Get from API
  List<Order> _pendingOrders = []; // TODO: Get from API
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchPendingOrders();
  }

  Future<void> _fetchPendingOrders() async {
    setState(() => _isLoading = true);

    // TODO: Implement API call to fetch pending orders
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _pendingOrders = []; // TODO: Replace with actual API response
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Labour'),
        backgroundColor: Colors.deepOrange,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Available Labourers:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _availableLabourers.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _pendingOrders.isEmpty
                      ? const Center(child: Text('No pending orders'))
                      : ListView.builder(
                          itemCount: _pendingOrders.length,
                          itemBuilder: (context, index) {
                            final order = _pendingOrders[index];
                            final remainingLabourers =
                                order.requiredLabourers -
                                order.assignedLabourers;

                            return Card(
                              margin: const EdgeInsets.all(8),
                              child: ListTile(
                                title: Text('Order #${order.orderNo}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(order.customerName),
                                    Text(
                                      'Required: ${order.requiredLabourers}',
                                    ),
                                    Text(
                                      'Assigned: ${order.assignedLabourers}',
                                    ),
                                    Text(
                                      'Remaining: $remainingLabourers',
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: ElevatedButton(
                                  onPressed:
                                      _availableLabourers > 0 &&
                                          remainingLabourers > 0
                                      ? () {
                                          // TODO: Implement assign labour logic
                                        }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepOrange,
                                  ),
                                  child: const Text('Assign'),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
