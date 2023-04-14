import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoskd/app/core/helpers/FormatUang.dart';

import 'tutup_kas_kasir_controller.dart';

class TutupKasKasirPage extends GetView<TutupKasKasirController> {
  const TutupKasKasirPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Tutup kas kasir'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(
          () => ListView(
            children: [
              Container(
                child: controller.data['kasir'] == null
                    ? Padding(
                        padding: const EdgeInsets.all(50),
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.green),
                        ),
                      )
                    : Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Kasir',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${controller.data['kasir'] != null ? controller.data['kasir']['nama'] : null}',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'buka oleh',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${controller.data['buka_olehs'] != null ? controller.data['buka_olehs']['nama'] : null}',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Kas awal',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${FormatUang.keIdr(controller.data['kas_awal'] != null ? controller.data['kas_awal'] : 0, 0)}',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Uang masuk',
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 18),
                                    ),
                                    Text(
                                      '${FormatUang.keIdr(controller.data['uang_masuk'] != null ? controller.data['uang_masuk'] : 0, 0)}',
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 18),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Uang keluar',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 18),
                                    ),
                                    Text(
                                      '${FormatUang.keIdr(controller.data['uang_keluar'] != null ? controller.data['uang_keluar'] : 0, 0)}',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 18),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Kas akhir (diaplikasi)',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${FormatUang.keIdr(controller.data['kas_akhir'] != null ? controller.data['kas_akhir'] : 0, 0)}',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                TextField(
                                  controller: controller.kasTutupC,
                                  onChanged: (value) {
                                    if (value.isNotEmpty &&
                                        value.isNumericOnly) {
                                      var selisihData = int.parse(value) -
                                          controller.data['kas_akhir'];
                                      controller.selisih.value =
                                          selisihData.toInt();
                                      controller.kas_tutup.value =
                                          int.parse(value);
                                    } else {
                                      controller.kas_tutup.value = 0;
                                      controller.selisih.value =
                                          controller.data['kas_akhir'] != null
                                              ? controller.data['kas_akhir']
                                              : 0;
                                    }
                                    controller.hitungSisaDikasir(
                                        controller.kas_ditarik.value);
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red),
                                    ),
                                    // errorText: controller.validatePhone,
                                    prefixIcon: const Icon(
                                      Icons.backspace_rounded,
                                      color: Colors.white,
                                    ),
                                    fillColor: Colors.lightGreen,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: 'Kas tutup (tunai saat ini)',
                                    hintStyle: TextStyle(
                                      color: Colors.white70,
                                    ),
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                      horizontal: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Selisih',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Obx(
                                      () => Text(
                                        '${FormatUang.keIdr(controller.selisih.value, 0)}',
                                        style: TextStyle(
                                            color: controller.selisih.value < 0
                                                ? Colors.red
                                                : Colors.green,
                                            fontSize: 18),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                TextField(
                                  controller: controller.kasdiTarikC,
                                  onChanged: (value) {
                                    if (value.isNotEmpty &&
                                        value.isNumericOnly) {
                                      controller
                                          .hitungSisaDikasir(int.parse(value));
                                      // controller.sisa_dikasir.value =
                                      //     controller.kas_tutup.value - int.parse(value);
                                    } else {
                                      controller.kas_ditarik.value = 0;
                                      controller.sisa_dikasir.value =
                                          controller.kas_tutup.value;
                                      // kas tutup - kas ditarik
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red),
                                    ),
                                    // errorText: controller.validatePhone,
                                    prefixIcon: const Icon(
                                      Icons.price_check,
                                      color: Colors.white,
                                    ),
                                    fillColor: Colors.green,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: 'Kas ditarik (ke kas besar))',
                                    hintStyle: TextStyle(
                                      color: Colors.white70,
                                    ),
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                      horizontal: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Sisa dikasir',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${FormatUang.keIdr(controller.sisa_dikasir.value, 0)}',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 18),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Jumlah penjualan',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${controller.data['jumlah_penjualan'] != null ? controller.data['jumlah_penjualan'] : 0}',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Uang tunai',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${FormatUang.keIdr(controller.data['uang_tunai'] != null ? controller.data['uang_tunai'] : 0, 0)}',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Uang non tunai',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${FormatUang.keIdr(controller.data['uang_nontunai'] != null ? controller.data['uang_nontunai'] : 0, 0)}',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'omset',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${FormatUang.keIdr(controller.data['omset'] != null ? controller.data['omset'] : 0, 0)}',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'untung',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${FormatUang.keIdr(controller.data['untung'] != null ? controller.data['untung'] : 0, 0)}',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            child: InkWell(
                              onTap: () {
                                controller.loadingSimpan == true
                                    ? null
                                    : controller.simpanData();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color: Colors.blue,
                                ),
                                child: Center(
                                  child: controller.loadingSimpan == true
                                      ? CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          'Simpan',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
