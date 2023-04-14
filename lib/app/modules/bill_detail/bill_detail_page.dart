import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoskd/app/core/helpers/FormatUang.dart';

import 'bill_detail_controller.dart';

class BillDetailPage extends GetView<BillDetailController> {
  const BillDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill Detail'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Obx(
        () => controller.loadingData == true
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              )
            : Column(
                children: [
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Waktu',
                              style: TextStyle(fontSize: 17),
                            ),
                            Text(
                              '${controller.bill['created_at_human']}',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'No bill',
                              style: TextStyle(fontSize: 17),
                            ),
                            Text(
                              '${controller.bill['no_bill']}',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nama Pelanggan',
                              style: TextStyle(fontSize: 17),
                            ),
                            Text(
                              '${controller.bill['pelanggan_nama']}',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total pembayaran',
                              style: TextStyle(fontSize: 17),
                            ),
                            Text(
                              '${FormatUang.keIdr(double.parse(controller.bill['total_pembayaran']), 0)}',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'dibuat oleh',
                              style: TextStyle(fontSize: 17),
                            ),
                            Text(
                              '${controller.bill['user'] != null ? controller.bill['user']['nama'] : '-'}',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.maxFinite,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                      'ITEM PRODUK',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.bill['bill_item'].length,
                      itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        color: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${controller.bill['bill_item'][index]['produk_nama']} (${controller.bill['bill_item'][index]['satuan']})'),
                            Text(
                                '${FormatUang.keNominal(double.parse(controller.bill['bill_item'][index]['qty']), 0)} x ${FormatUang.keNominal(double.parse(controller.bill['bill_item'][index]['harga_jual']), 0)} = ${FormatUang.keIdr(double.parse(controller.bill['bill_item'][index]['total_harga_jual']), 0)}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                      width: double.maxFinite,
                      color: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              BlueThermalPrinter printer =
                                  BlueThermalPrinter.instance;
                              // DateTime now = DateTime.now();
                              // var waktu = DateTime.now();

                              printer.printCustom('TOKO SKD', 2, 1);
                              printer.printCustom(
                                  controller.bill['created_at'], 0, 1);
                              printer.printCustom(
                                '${controller.bill['no_bill']}',
                                0,
                                1,
                              );
                              printer.printLeftRight('Pelanggan',
                                  controller.bill['pelanggan_nama'], 0);
                              printer.printLeftRight(
                                  'Kasir',
                                  controller.bill['user'] != null
                                      ? controller.bill['user']['nama']
                                      : '-',
                                  0);
                              printer.write('================================');
                              printer.printCustom('BELUM BAYAR (BILL)', 1, 1);
                              printer.write('================================');
                              for (var e in controller.bill['bill_item']) {
                                printer.printCustom(
                                    '${e['produk_nama']} (${e['satuan']})',
                                    1,
                                    0);
                                printer.printLeftRight(
                                    '${FormatUang.keNominal(double.parse(e['qty']), 0)} x ${FormatUang.keNominal(double.parse(e['harga_jual']), 0)}',
                                    '${FormatUang.keNominal(double.parse(e['total_harga_jual']), 0)}',
                                    0);
                              }
                              printer.write('================================');
                              printer.printLeftRight(
                                  'Subtotal',
                                  '${FormatUang.keIdr(double.parse(controller.bill['total_harga_jual']), 0)}',
                                  0);
                              printer.printLeftRight(
                                  'potongan',
                                  '${FormatUang.keIdr(double.parse(controller.bill['potongan_diskon']), 0)}',
                                  0);
                              // printer.printNewLine();
                              printer.printLeftRight(
                                  'Total Bayar',
                                  '${FormatUang.keIdr(double.parse(controller.bill['total_pembayaran']), 0)}',
                                  1);
                              printer.write('================================');
                              printer.printCustom('SEGERA BAYAR', 0, 1);
                              printer.printCustom('~Terima kasih~', 0, 1);
                              printer.printNewLine();
                              printer.printNewLine();
                              printer.paperCut();
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.blue,
                              ),
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  'Cetak',
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          controller.loadingProses == true
                              ? InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.green,
                                    ),
                                    width: double.infinity,
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.white,
                                    )),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    controller
                                        .prosesBill(controller.bill['id']);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.green,
                                    ),
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        'Proses bill (Transaksi)',
                                        style: TextStyle(
                                          // fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                        ],
                      )),
                ],
              ),
      ),
    );
  }
}
