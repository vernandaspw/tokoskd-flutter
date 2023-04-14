import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoskd/app/core/helpers/FormatUang.dart';

import 'kasir_terima_kas_controller.dart';

class KasirTerimaKasPage extends GetView<KasirTerimaKasController> {
  const KasirTerimaKasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terima Kas kasir'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Obx(
          () => RefreshIndicator(
            onRefresh: () async {
              controller.getTerimaKas(Get.parameters['id']);
              // controller.hitungSisaDikasir(0);
            },
            child: controller.data['kasir'] == null
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.green,
                    )),
                  )
                : ListView(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Kasir',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      '${controller.data['kasir'] != null ? controller.data['kasir']['nama'] : null}',
                                      style: TextStyle(fontSize: 18),
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
                                      'jam buka',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      '${controller.data['jam_buka'] != null ? controller.data['jam_buka'] : null}',
                                      style: TextStyle(fontSize: 18),
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
                                      'jam tutup',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      '${controller.data['jam_tutup'] != null ? controller.data['jam_tutup'] : null}',
                                      style: TextStyle(fontSize: 18),
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
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      '${controller.data['buka_olehs'] != null ? controller.data['buka_olehs']['nama'] : null}',
                                      style: TextStyle(fontSize: 18),
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
                                      'tutup oleh',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      '${controller.data['tutup_olehs'] != null ? controller.data['tutup_olehs']['nama'] : null}',
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
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
                                      'Kas awal',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      '${FormatUang.keIdr(controller.data['kas_awal'] != null ? controller.data['kas_awal'] : 0, 0)}',
                                      style: TextStyle(fontSize: 18),
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
                                      '${FormatUang.keIdr(controller.data['total_uang_masuk'] != null ? controller.data['total_uang_masuk'] : 0, 0)}',
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
                                      '${FormatUang.keIdr(controller.data['total_uang_keluar'] != null ? controller.data['total_uang_keluar'] : 0, 0)}',
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
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      '${FormatUang.keIdr(controller.data['kas_akhir'] != null ? controller.data['kas_akhir'] : 0, 0)}',
                                      style: TextStyle(fontSize: 18),
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
                                      'Kas tutup',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      '${FormatUang.keIdr(controller.data['kas_tutup'] != null ? controller.data['kas_tutup'] : 0, 0)}',
                                      style: TextStyle(fontSize: 18),
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
                                      'Selisih',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      '${FormatUang.keIdr(controller.data['selisih'] != null ? controller.data['selisih'] : 0, 0)}',
                                      style: TextStyle(
                                        color:
                                            controller.data['selisih'] != null
                                                ? controller.data['selisih'] < 0
                                                    ? Colors.red
                                                    : Colors.green
                                                : Colors.green,
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
                                      'Kas ditarik',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${FormatUang.keIdr(controller.data['kas_ditarik'] != null ? controller.data['kas_ditarik'] : 0, 0)}',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
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
                                      'sisa dikasir sebelumnya',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      '${FormatUang.keIdr(controller.data['sisa_dikasir'] != null ? controller.data['sisa_dikasir'] : 0, 0)}',
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          // Text Field
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Kas ditarik yg diterima (ke kas besar)',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                TextField(
                                  controller: controller.kasdiTarikC,
                                  onChanged: (value) {
                                    if (value.isNotEmpty &&
                                        value.isNumericOnly) {
                                      controller.kas_ditarik.value =
                                          int.parse(value);
                                      controller.hitungSisaDikasir(
                                        int.parse(value),
                                      );
                                    } else {
                                      controller.kas_ditarik.value =
                                          controller.data['kas_ditarik'];
                                      controller.sisa_dikasir.value =
                                          controller.data['sisa_dikasir'] !=
                                                  null
                                              ? controller.data['sisa_dikasir']
                                              : 0;
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
                                    hintText:
                                        'Kas ditarik yg diterima (ke kas besar)',
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
                                      'Sisa dikasir terbaru',
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
                          // End TextField
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
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
                                      '${controller.data['jumlah_transaksi'] != null ? controller.data['jumlah_transaksi'] : 0}',
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
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      '${FormatUang.keIdr(controller.data['uang_tunai'] != null ? controller.data['uang_tunai'] : 0, 0)}',
                                      style: TextStyle(fontSize: 18),
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
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      '${FormatUang.keIdr(controller.data['uang_nontunai'] != null ? controller.data['uang_nontunai'] : 0, 0)}',
                                      style: TextStyle(fontSize: 18),
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
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      '${FormatUang.keIdr(controller.data['omset'] != null ? controller.data['omset'] : 0, 0)}',
                                      style: TextStyle(fontSize: 18),
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
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      '${FormatUang.keIdr(controller.data['untung'] != null ? controller.data['untung'] : 0, 0)}',
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
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
                                padding: const EdgeInsets.all(13),
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
                          SizedBox(
                            height: 35,
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
