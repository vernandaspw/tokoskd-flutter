import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'kasir_kas_keluar_controller.dart';

class KasirKasKeluarPage extends GetView<KasirKasKeluarController> {
  const KasirKasKeluarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KasirKasKeluarPage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'KasirKasKeluarPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
