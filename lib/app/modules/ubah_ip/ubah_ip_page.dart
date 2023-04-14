import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ubah_ip_controller.dart';

class UbahIpPage extends GetView<UbahIpController> {
  const UbahIpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('UbahIpPage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Not yet',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
