import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final bool showDetails;
  final Function()? onLocationTap;
  final Function()? onStatusUpdate;

  const OrderCard({
    super.key,
    required this.order,
    this.showDetails = true,
    this.onLocationTap,
    this.onStatusUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order.orderNo}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                _buildStatusChip(),
              ],
            ),
            const SizedBox(height: 12),
            if (showDetails) ...[
              Text('Customer: ${order.customerName}'),
              const SizedBox(height: 8),
            ],
            InkWell(
              onTap: onLocationTap,
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.deepOrange),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      order.isTruckFilling
                          ? 'Pickup: ${order.pickupLocation}'
                          : 'Drop-off: ${order.dropoffLocation}',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text('Date: ${order.dateTime.toString().split('.')[0]}'),
            const SizedBox(height: 8),
            Text('Vehicle: ${order.vehicleNumber}'),
            if (showDetails) ...[
              const SizedBox(height: 8),
              Text('Transporter: ${order.transporterName}'),
              const SizedBox(height: 4),
              Text('Contact: ${order.transporterContact}'),
            ],
            const SizedBox(height: 8),
            Text('Payment: ${order.paymentMethod.toString().split('.').last}'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Labour: ${order.assignedLabourers}/${order.requiredLabourers}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (order.status != OrderStatus.completed &&
                    onStatusUpdate != null)
                  ElevatedButton(
                    onPressed: onStatusUpdate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                    ),
                    child: Text(
                      order.status == OrderStatus.arrived
                          ? 'Start'
                          : order.status == OrderStatus.inProgress
                          ? 'Complete'
                          : 'Update',
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip() {
    Color color;
    switch (order.status) {
      case OrderStatus.arrived:
        color = Colors.blue;
        break;
      case OrderStatus.inProgress:
        color = Colors.orange;
        break;
      case OrderStatus.completed:
        color = Colors.green;
        break;
      case OrderStatus.rejected:
        color = Colors.red;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        order.status.toString().split('.').last,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
