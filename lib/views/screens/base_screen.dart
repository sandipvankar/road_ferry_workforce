import 'package:flutter/material.dart';
import 'package:road_ferry_labour/utils/reachability.dart';

abstract class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});
}

abstract class BaseScreenState<T extends BaseScreen> extends State<T> {
  @override
  void initState() {
    super.initState();
    Reachability().initialize(context); // Initialize Reachability
  }

  @override
  void dispose() {
    Reachability().dispose(); // Dispose subscription
    super.dispose();
  }
}
