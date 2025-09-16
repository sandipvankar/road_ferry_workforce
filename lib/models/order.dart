
enum OrderStatus { arrived, inProgress, completed, rejected }

enum PaymentMethod { cash, online, creditCard }

class Order {
  final String id;
  final String orderNo;
  final String customerName;
  final String pickupLocation;
  final String dropoffLocation;
  final DateTime dateTime;
  final String vehicleNumber;
  final String transporterName;
  final String transporterContact;
  final PaymentMethod paymentMethod;
  final OrderStatus status;
  final bool isTruckFilling;
  final int requiredLabourers;
  final int assignedLabourers;

  Order({
    required this.id,
    required this.orderNo,
    required this.customerName,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.dateTime,
    required this.vehicleNumber,
    required this.transporterName,
    required this.transporterContact,
    required this.paymentMethod,
    required this.status,
    required this.isTruckFilling,
    required this.requiredLabourers,
    required this.assignedLabourers,
  });
}
