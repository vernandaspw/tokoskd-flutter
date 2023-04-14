import 'package:flutter/material.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:get/get.dart';

import 'tes_barcode_scanner_controller.dart';

class TesBarcodeScannerPage extends GetView<TesBarcodeScannerController> {
  const TesBarcodeScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TesBarcodeScannerPage'),
        centerTitle: true,
      ),
      body: Obx(
        () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Scan result:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                '${controller.barcode}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              SizedBox(height: 10),
              BarcodeKeyboardListener(
                bufferDuration: Duration(milliseconds: 200),
                onBarcodeScanned: (val) {
                  controller.barcode.value = val;
                },
                child: const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
