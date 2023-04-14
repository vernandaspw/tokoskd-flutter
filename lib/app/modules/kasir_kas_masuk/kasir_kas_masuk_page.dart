import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'kasir_kas_masuk_controller.dart';

class KasirKasMasukPage extends GetView<KasirKasMasukController> {
  const KasirKasMasukPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KasirKasMasukPage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'KasirKasMasukPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
