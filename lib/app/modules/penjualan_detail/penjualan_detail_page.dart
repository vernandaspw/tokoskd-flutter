import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoskd/app/core/helpers/FormatUang.dart';

import 'penjualan_detail_controller.dart';

class PenjualanDetailPage extends GetView<PenjualanDetailController> {
  const PenjualanDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penjualan Detail'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Obx(
        () => controller.loadingData.value == true
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              )
            : Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        'TRANSAKSI BERHASIL',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Center(
                      child: Text('${controller.penjualan['waktu']}'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('No order'),
                        Text('${controller.penjualan['no_penjualan']}')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Pelanggan'),
                        Text(
                            '${controller.penjualan['pelanggan'] != null ? controller.penjualan['pelanggan']['nama'] : '-'}')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Kasir'),
                        Text(
                            '${controller.penjualan['user'] != null ? controller.penjualan['user']['nama'] : '-'}')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Pembayaran'),
                        Text(
                            '${controller.penjualan['uang_tunai'] != null ? 'tunai' : 'non tunai'}')
                      ],
                    ),
                    Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            controller.penjualan['penjualan_item'].length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${controller.penjualan['penjualan_item'][index]['produk']['nama']} (${controller.penjualan['penjualan_item'][index]['satuan']['satuan']})'),
                                Text(
                                    '${controller.penjualan['penjualan_item'][index]['qty']} x ${FormatUang.keNominal(controller.penjualan['penjualan_item'][index]['harga_jual'], 0)} = ${FormatUang.keIdr(controller.penjualan['penjualan_item'][index]['total_harga_jual'], 0)}'),
                                SizedBox(
                                  height: 4,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal'),
                        Text(
                            '${FormatUang.keIdr(double.parse(controller.penjualan['total_harga_jual']), 0)}')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Potongan'),
                        Text(
                            '${FormatUang.keIdr(double.parse(controller.penjualan['potongan_diskon']), 0)}')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total bayar',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${FormatUang.keIdr(double.parse(controller.penjualan['total_pembayaran']), 0)}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Bayar'),
                        Text(
                            '${FormatUang.keIdr(double.parse(controller.penjualan['diterima']), 0)}')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Kembali'),
                        Text(
                            '${FormatUang.keIdr(double.parse(controller.penjualan['kembali']), 0)}')
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              BlueThermalPrinter printer =
                                  BlueThermalPrinter.instance;
                              printer.printCustom('TOKO SKD', 2, 1);
                              printer.printCustom(
                                  controller.penjualan['waktu'], 0, 1);
                              printer.printCustom(
                                '${controller.penjualan['no_penjualan']}',
                                0,
                                1,
                              );
                              printer.printLeftRight(
                                  'Pelanggan',
                                  controller.penjualan['pelanggan'] != null
                                      ? controller.penjualan['pelanggan']
                                          ['nama']
                                      : '-',
                                  0);
                              printer.printLeftRight(
                                  'Kasir',
                                  controller.penjualan['user'] != null
                                      ? controller.penjualan['user']['nama']
                                      : '-',
                                  0);
                              if (controller.penjualan['islunas'] == 0) {
                                printer
                                    .write('================================');
                                printer.printCustom('BELUM LUNAS', 1, 1);
                              }
                              printer.write('================================');
                              for (var e
                                  in controller.penjualan['penjualan_item']) {
                                printer.printCustom(
                                    '${e['produk']['nama']} (${e['satuan']['satuan']})',
                                    1,
                                    0);
                                printer.printLeftRight(
                                    '${FormatUang.keNominal(e['qty'], 0)} x ${FormatUang.keNominal(e['harga_jual'], 0)}',
                                    '${FormatUang.keNominal(e['total_harga_jual'], 0)}',
                                    0);
                              }
                              printer.write('================================');
                              printer.printLeftRight(
                                  'Subtotal',
                                  '${FormatUang.keIdr(double.parse(controller.penjualan['total_harga_jual']), 0)}',
                                  0);
                              printer.printLeftRight(
                                  'potongan',
                                  '${FormatUang.keIdr(double.parse(controller.penjualan['potongan_diskon']), 0)}',
                                  0);
                              // printer.printNewLine();
                              printer.printLeftRight(
                                  'Total Bayar',
                                  '${FormatUang.keIdr(double.parse(controller.penjualan['total_pembayaran']), 0)}',
                                  1);
                              printer.printLeftRight(
                                  'bayar',
                                  '${FormatUang.keIdr(double.parse(controller.penjualan['diterima']), 0)}',
                                  0);
                              printer.printLeftRight(
                                  'Kembali',
                                  '${FormatUang.keIdr(double.parse(controller.penjualan['kembali']), 0)}',
                                  0);
                              printer.write('================================');
                              printer.printCustom(
                                  'Struk berlaku 1x24 jam', 0, 1);
                              printer.printCustom('~Terima kasih~', 0, 1);

                              printer.printNewLine();
                              printer.printNewLine();
                              printer.printNewLine();
                              printer.paperCut();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 100),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(2, 6),
                                      blurRadius: 8,
                                      color: Colors.black38
                                      // spreadRadius: 1,
                                      ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  "Cetak struk",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
