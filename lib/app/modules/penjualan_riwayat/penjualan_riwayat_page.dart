import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'penjualan_riwayat_controller.dart';

class PenjualanRiwayatPage extends GetView<PenjualanRiwayatController> {
  const PenjualanRiwayatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Penjualan'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          'Maintance',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
