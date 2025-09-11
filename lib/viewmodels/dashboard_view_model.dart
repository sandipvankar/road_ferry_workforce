import 'package:flutter/material.dart';
import '../models/order.dart';

class DashboardViewModel extends ChangeNotifier {
  List<Order> _activeOrders = [];
  List<Order> _pendingOrders = [];
  List<Order> _rejectedOrders = [];
  List<Order> _completedOrders = [];
  bool _isLoading = false;

  List<Order> get activeOrders => _activeOrders;
  List<Order> get pendingOrders => _pendingOrders;
  List<Order> get rejectedOrders => _rejectedOrders;
  List<Order> get completedOrders => _completedOrders;
  bool get isLoading => _isLoading;

  Future<void> fetchOrders() async {
    _setLoading(true);

    // TODO: Implement API call to fetch orders
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call

    // TODO: Replace with actual API response
    _activeOrders = [];
    _pendingOrders = [];
    _rejectedOrders = [];
    _completedOrders = [];

    _setLoading(false);
  }

  Future<void> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    _setLoading(true);

    // TODO: Implement API call to update order status
    await Future.delayed(const Duration(seconds: 1)); // Simulate API call

    await fetchOrders(); // Refresh orders after update
  }

  Future<bool> verifyOtp(String orderId, String otp) async {
    _setLoading(true);

    // TODO: Implement OTP verification
    await Future.delayed(const Duration(seconds: 1)); // Simulate API call

    _setLoading(false);
    return true; // Return actual verification result
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
