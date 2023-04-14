import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoskd/app/core/helpers/FormatUang.dart';

import 'tutup_kas_kasir_struk_controller.dart';

class TutupKasKasirStrukPage extends GetView<TutupKasKasirStrukController> {
  const TutupKasKasirStrukPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Berhasil Tutup Kas kasir'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(
          () => Container(
            child: RefreshIndicator(
              onRefresh: () async {
                controller.getReport(Get.parameters['id']);
                controller.getPrinter();
              },
              child: ListView(
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
                            Text(
                              'Berhasil Tutup kas kasir',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Selisih',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Obx(
                                  () => Text(
                                    '${FormatUang.keIdr(controller.data['selisih'] != null ? controller.data['selisih'] : 0, 0)}',
                                    style: TextStyle(
                                      color: controller.data['selisih'] != null
                                          ? controller.data['selisih'] < 0
                                              ? Colors.red
                                              : Colors.green
                                          : Colors.green,
                                      fontSize: 18,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Kas ditarik',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '${FormatUang.keIdr(controller.data['kas_ditarik'] != null ? controller.data['kas_ditarik'] : 0, 0)}',
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'sisa dikasir',
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
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      InkWell(
                        onTap: () {
                          controller.printer.printCustom(
                              '${controller.data['kasir']['nama'] != null ? controller.data['kasir']['nama'] : '-'}',
                              2,
                              1);
                          controller.printer
                              .printCustom('Laporan tutup kasir', 0, 1);
                          controller.printer
                              .write('================================');
                          controller.printer.printLeftRight(
                              'Buka oleh',
                              '${controller.data['buka_olehs'] != null ? controller.data['buka_olehs']['nama'] : '-'}',
                              0);
                          controller.printer.printCustom(
                              '${controller.data['jam_buka'] != null ? controller.data['jam_buka'] : '-'}',
                              0,
                              2);
                          controller.printer.printLeftRight(
                              'Tutup oleh',
                              '${controller.data['tutup_olehs'] != null ? controller.data['tutup_olehs']['nama'] : '-'}',
                              0);
                          controller.printer.printCustom(
                              '${controller.data['jam_tutup'] != null ? controller.data['jam_tutup'] : '-'}',
                              0,
                              2);
                          controller.printer
                              .write('================================');
                          controller.printer.printLeftRight(
                              'Kas awal',
                              '${FormatUang.keNominal(controller.data['kas_awal'] != null ? controller.data['kas_awal'] : '0', 0)}',
                              0);
                          controller.printer.printLeftRight(
                              'Uang masuk',
                              '${FormatUang.keNominal(controller.data['total_uang_masuk'] != null ? controller.data['total_uang_masuk'] : 0, 0)}',
                              0);
                          controller.printer.printLeftRight(
                              'Uang Keluar',
                              '${FormatUang.keNominal(controller.data['total_uang_keluar'] != null ? controller.data['total_uang_keluar'] : 0, 0)}',
                              0);
                          controller.printer.printLeftRight(
                              'Kas akhir',
                              '${FormatUang.keNominal(controller.data['kas_akhir'] != null ? controller.data['kas_akhir'] : 0, 0)}',
                              0);
                          controller.printer.printLeftRight(
                              'Kas tutup',
                              '${FormatUang.keNominal(controller.data['kas_tutup'] != null ? controller.data['kas_tutup'] : 0, 0)}',
                              0);
                          controller.printer.printLeftRight(
                              'Selisih',
                              '${FormatUang.keNominal(controller.data['selisih'] != null ? controller.data['selisih'] : 0, 0)}',
                              0);
                          controller.printer.printLeftRight(
                              'Kas ditarik',
                              '${FormatUang.keNominal(controller.data['kas_ditarik'] != null ? controller.data['kas_ditarik'] : 0, 0)}',
                              0);
                          controller.printer.printLeftRight(
                              'Sisa dikasir',
                              '${FormatUang.keNominal(controller.data['sisa_dikasir'] != null ? controller.data['sisa_dikasir'] : 0, 0)}',
                              0);
                          controller.printer
                              .write('================================');
                          controller.printer.printLeftRight(
                              'Jml Penjualan',
                              '${FormatUang.keNominal(controller.data['jumlah_transaksi'] != null ? controller.data['jumlah_transaksi'] : 0, 0)}',
                              0);
                          controller.printer.printLeftRight(
                              'Uang tunai',
                              '${FormatUang.keNominal(controller.data['uang_tunai'] != null ? controller.data['uang_tunai'] : 0, 0)}',
                              0);
                          controller.printer.printLeftRight(
                              'Uang nontunai',
                              '${FormatUang.keNominal(controller.data['uang_nontunai'] != null ? controller.data['uang_nontunai'] : 0, 0)}',
                              0);
                          controller.printer.printLeftRight(
                              'Omset',
                              '${FormatUang.keNominal(controller.data['omset'] != null ? controller.data['omset'] : 0, 0)}',
                              0);
                          controller.printer.printLeftRight(
                              'Untung',
                              '${FormatUang.keNominal(controller.data['untung'] != null ? controller.data['untung'] : 0, 0)}',
                              0);
                          controller.printer
                              .write('================================');
                          controller.printer.printCustom(
                              'Segera konfirmasi terima laporan', 0, 1);

                          controller.printer.printNewLine();
                          controller.printer.printNewLine();
                          controller.printer.printNewLine();
                          controller.printer.paperCut();
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          padding: EdgeInsets.all(12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                              child: Text(
                            'Cetak Struk',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          controller.refreshData();
                          Get.back();
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          padding: EdgeInsets.all(12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                              child: Text(
                            'Kembali',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
