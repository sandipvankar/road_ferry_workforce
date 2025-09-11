import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/material.dart';

class Reachability {
  static final Reachability _instance = Reachability._internal();
  factory Reachability() => _instance;
  Reachability._internal();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _subscription;

  void initialize(BuildContext context) {
    _subscription = _connectivity.onConnectivityChanged.listen((result) async {
      bool isConnected = await InternetConnectionChecker().hasConnection;

      // Check if context is still valid before showing dialog
      if (!isConnected && context.mounted) {
        _showNoInternetDialog(context);
      }
    });
  }

  Future<bool> checkInternet() async {
    return await InternetConnectionChecker().hasConnection;
  }

  void _showNoInternetDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text("No Internet Connection"),
        content: const Text("Please check your internet and try again."),
        actions: [
          TextButton(
            onPressed: () async {
              bool connected = await checkInternet();
              if (connected && dialogContext.mounted) {
                Navigator.of(dialogContext).pop(); // Close dialog safely
              }
            },
            child: const Text("Retry"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              // Optional: Exit app
            },
            child: const Text("Exit"),
          ),
        ],
      ),
    );
  }

  void dispose() {
    _subscription?.cancel();
  }
}
