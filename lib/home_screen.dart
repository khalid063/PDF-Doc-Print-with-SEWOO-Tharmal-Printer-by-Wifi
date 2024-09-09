import 'package:flutter/material.dart';
import 'package:flutter_esc_pos_network/flutter_esc_pos_network.dart';
import 'package:flutter_esc_pos_network/flutter_esc_pos_network.dart';

import 'network_printer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final networkPrinter = NetworkPrinter(); // Create NetworkPrinter instance

  @override
  void initState() {
    super.initState();
    // Connect to printer in initState (after widget is built)
    _connectToPrinter();
  }

  Future<void> _connectToPrinter() async {
    final connect = await networkPrinter.printer.connect();
    if (connect == PosPrintResult.success) {
      print('Connected to printer successfully!');
    } else {
      print('Error connecting to printer: ${connect.msg}');
    }
  }


  void testReceipt() {
    networkPrinter.testTicket().then((ticket) {
      // Print the ticket after generating it
      networkPrinter.printTicket(ticket);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: testReceipt,
          child: const Text('Print Receipt'),
        ),
      ),
    );
  }
}

// class NetworkPrinter {
//   final PrinterNetworkManager printer = PrinterNetworkManager('your_printer_ip');
// }