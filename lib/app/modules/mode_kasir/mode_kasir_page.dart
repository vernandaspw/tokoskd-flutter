import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:get/get.dart';
// import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:tokoskd/app/core/helpers/FormatUang.dart';
import 'package:tokoskd/app/core/theme/tema.dart';
import 'package:tokoskd/app/modules/mode_kasir/WidgetBtnNominal.dart';

import 'mode_kasir_controller.dart';

class ModeKasirPage extends GetView<ModeKasirController> {
  const ModeKasirPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaWidth = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).size.width >= 600.0) {
      return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Mode kasir'),
        //   centerTitle: true,
        //   backgroundColor: Colors.green,
        //   actions: [
        //     InkWell(
        //       onTap: () async {
        //         // controller.scanBarcode();
        //         controller.scanBarcodeNormal();
        //       },
        //       child: Container(
        //         padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
        //         child: Icon(
        //           Icons.qr_code_scanner,
        //         ),
        //       ),
        //     ),
        //     SizedBox(
        //       width: 10,
        //     ),
        //     SizedBox(
        //       width: 10,
        //     ),
        //   ],
        // ),
        backgroundColor: Colors.greenAccent,
        body: Obx(
          () => SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: mediaWidth / 2.45,
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                    child: MenuProduk()),
                Container(
                  width: mediaWidth / 1.70,
                  // color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                        color: Colors.yellow,
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.shopping_cart),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Keranjang',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                InkWell(
                                  onTap: () async {
                                    // controller.scanBarcode();
                                    controller.scanBarcodeNormal();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(9, 2, 9, 2),
                                    child: Icon(
                                      Icons.qr_code_scanner,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.toNamed('/penjualan-riwayat');
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(6, 7, 6, 7),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Riwayat',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                        '/bill-penjualan/${controller.kasirid}');
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(10, 7, 10, 7),
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Text(
                                      'Bill (${controller.jmlBill})',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CartStorageWidget(),
                        ),
                      ),
                      Container(
                        color: Colors.green,
                        height: 4,
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.fromLTRB(10, 8, 10, 5),
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Text(
                                //   'TOTAL: ${FormatUang.keIdr(controller.total_bayar.toDouble(), 0)}',
                                //   style: TextStyle(
                                //     fontSize: 20,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                // Container(
                                //   width: 140,
                                //   child: TextField(
                                //     keyboardType: TextInputType.number,
                                //     autocorrect: true,
                                //     controller: controller.inputKembaliC,
                                //     onChanged: (val) {
                                //       if (val.isNumericOnly) {
                                //         var kembali = val == null ? 0 : val;
                                //         controller.diterima.value =
                                //             int.parse(val);
                                //         controller.kembali.value =
                                //             int.parse(val) -
                                //                 controller.total_bayar.value;
                                //         controller.fetchCart();
                                //       } else {
                                //         print('huruf');
                                //       }
                                //     },
                                //     // keyboardType: TextInputType.phone,
                                //     decoration: InputDecoration(
                                //       fillColor: Colors.yellow,
                                //       filled: true,
                                //       border: OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(4),
                                //         // borderSide: BorderSide.none,
                                //       ),
                                //       hintText: 'Nominal kembalian',
                                //       isDense: true,
                                //       contentPadding:
                                //           const EdgeInsets.symmetric(
                                //         vertical: 6,
                                //         horizontal: 10,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            // SizedBox(
                            //   height: 5,
                            // ),
                            // WidgetBtnNominal(),
                            // SizedBox(
                            //   height: 5,
                            // ),
                            controller.billID.isEmpty
                                ? Container()
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        color: Colors.yellow,
                                        child: Text(
                                          "Bill aktif",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                      Text(
                                        "${controller.namaDariBill} - ${controller.noDariBill}",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Subtotal",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  "${FormatUang.keIdr(controller.subtotal.toDouble(), 0)}",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Potongan",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  "${FormatUang.keIdr(controller.potongan.toDouble(), 0)}",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Container(
                                //   child: Text(
                                //       'kembalian : ${FormatUang.keIdr(controller.kembali.toInt(), 0)}'),
                                // ),
                                Text(
                                  'TOTAL BAYAR:',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${FormatUang.keIdr(controller.total_bayar.toDouble(), 0)}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.removeAllcartStorage();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(10, 9, 10, 9),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Reset',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                controller.billID.isEmpty
                                    ? InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (context) =>
                                                SimpanBillPage(),
                                          );
                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 9, 10, 9),
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            'Simpan bill',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          controller
                                              .perbaruiBill(controller.billID);
                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 9, 10, 9),
                                          decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            'Perbarui bill',
                                            style: TextStyle(
                                                // color: Colors.white,
                                                ),
                                          ),
                                        ),
                                      ),
                                SizedBox(
                                  width: 7,
                                ),
                                InkWell(
                                  onTap: () {
                                    // modalbayar
                                    controller.inputKembaliC.clear();
                                    controller.diterima.value = 0;
                                    controller.kembali.value = 0;
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (_) {
                                        return PembayaranPage();
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(30, 9, 30, 9),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Bayar',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      // versi hp, tampilan hp
      return Scaffold(
        appBar: AppBar(
          title: const Text('Mode kasir'),
          centerTitle: false,
          backgroundColor: Colors.green,
          actions: [
            // InkWell(
            //   onTap: () async {
            //     // controller.scanBarcode();
            //     controller.startBarcodeScanStream();
            //   },
            //   child: Container(
            //     padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
            //     child: Icon(
            //       Icons.document_scanner,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   width: 1,
            // ),
            InkWell(
              onTap: () {
                Get.toNamed('/penjualan-riwayat');
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(6, 7, 6, 7),
                decoration: BoxDecoration(
                  // color: Colors.grey,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Center(
                  child: Text(
                    'Riwayat',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 4,
            ),
            InkWell(
              onTap: () async {
                // controller.scanBarcode();
                controller.scanBarcodeNormal();
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
                child: Icon(
                  Icons.qr_code_scanner,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Column(
              children: [
                // SizedBox.expand(
                //   child: Container(
                //     color: Colors.redAccent,
                //   ),
                // ),
                Expanded(child: MenuProduk()),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.black12,
                      isScrollControlled: true,
                      enableDrag: true,
                      context: context,
                      builder: ((context) {
                        return PageSheet();
                      }),
                    );
                  },
                  child: Container(
                      padding: EdgeInsets.fromLTRB(8, 15, 8, 11),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.shopping_cart_sharp),
                                    // Text(
                                    //   'Keranjang',
                                    //   style: TextStyle(
                                    //     fontWeight: FontWeight.w500,
                                    //     fontSize: 15,
                                    //   ),
                                    // ),

                                    SizedBox(
                                      width: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                            '/bill-penjualan/${controller.kasirid}');
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 10, 20, 10),
                                        decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                          child: Obx(() => Text(
                                                'Bill (${controller.jmlBill})',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.removeAllcartStorage();
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(15, 10, 15, 10),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        child: Text(
                                          'Reset',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    controller.billID.isEmpty
                                        ? Container()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Container(
                                                color: Colors.yellow,
                                                child: Text(
                                                  "Bill aktif ",
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ),
                                              Text(
                                                "- ${controller.noDariBill}",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                                Row(
                                  children: [],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(() => Container(
                                width: double.infinity,
                                // margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: controller.addCartLoading.value == true
                                      ? Colors.greenAccent
                                      : Colors.yellow,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${controller.total_item} Produk (${controller.qty} qty) = ",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        "${FormatUang.keIdr(controller.subtotal.toDouble(), 0)}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}

class MenuProduk extends GetView<ModeKasirController> {
  const MenuProduk({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaWidth = MediaQuery.of(context).size.width;
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BarcodeKeyboardListener(
            // bufferDuration: Duration(milliseconds: 200),
            useKeyDownEvent: false,
            onBarcodeScanned: (val) {
              controller.barcode.value = val;
              controller.cariBarcode(val);
            },
            child: const SizedBox(),
          ),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
              )
            ]),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => controller.produkBaru(),
                  child: Container(
                    margin: const EdgeInsets.all(0),
                    height: 39,
                    width: mediaWidth >= 600.0
                        ? mediaWidth / 7.35
                        : mediaWidth / 3,
                    decoration: BoxDecoration(
                      color: controller.produkPageIndex == 0
                          ? Colors.green
                          : Colors.grey,
                      // borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset:
                              const Offset(0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "Buat baru",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.produkLama(),
                  child: Container(
                    margin: const EdgeInsets.all(0),
                    height: 39,
                    width: mediaWidth >= 600.0
                        ? mediaWidth / 7.35
                        : mediaWidth / 3,
                    decoration: BoxDecoration(
                      color: controller.produkPageIndex == 1
                          ? Colors.green
                          : Colors.grey,
                      // borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset:
                              const Offset(0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "Produk",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.produkCustom(),
                  child: Container(
                    margin: const EdgeInsets.all(0),
                    height: 39,
                    width: mediaWidth >= 600.0
                        ? mediaWidth / 7.35
                        : mediaWidth / 3,
                    decoration: BoxDecoration(
                      color: controller.produkPageIndex == 2
                          ? Colors.green
                          : Colors.grey,
                      // borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset:
                              const Offset(0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "Custom",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1,
          ),
          // Tema.enter8,

          // buat produk baru
          controller.produkPageIndex == 0
              ? Container(
                  child: Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text('Buat baru'),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
          controller.produkPageIndex == 0
              ? Container(
                  width: Get.width,
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [Text('area aksi')],
                  ))
              : Container(),

// Produk
          controller.produkPageIndex == 1
              ? Container(
                  margin: EdgeInsets.all(5),
                  child: TextField(
                    controller: controller.cariProdukC,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        controller.cariNamaProduk(value);
                      } else if (value == '') {
                        controller.fetchProduk();
                      } else {
                        controller.fetchProduk();
                      }
                    },
                    // keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      // errorText: controller.validateUrl,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(width: 1, color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(width: 1, color: Colors.red),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(360),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Nama produk',
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 10,
                      ),
                    ),
                  ),
                )
              : Container(),
          controller.produkPageIndex == 1
              ? controller.isLoadingProduk == true
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      )),
                    )
                  : Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          controller.take.value = 20;
                          await controller.fetchProduk();
                          controller.takeProdukLain();
                        },
                        child: ListView.builder(
                          itemCount: controller.produkModel != null
                              ? controller.produkModel?.data.data.length
                              : 0,
                          // itemCount: controller.produkModel?.data.data.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Material(
                              color: Colors.green,
                              child: InkWell(
                                hoverColor: Colors.black,
                                splashColor: Colors.black,
                                focusColor: Colors.black,
                                // highlightColor: Colors.black,
                                onTap: () {
                                  // controller.addCart(controller
                                  //     .produkModel?.data.data[index].id
                                  //     .toString());

                                  controller.addCartStorage(
                                    controller
                                        .produkModel?.data.data[index].produkId,
                                    controller.produkModel?.data.data[index]
                                        .produk.nama,
                                    controller.produkModel?.data.data[index]
                                        .produk.merekId,
                                    controller.produkModel?.data.data[index]
                                        .produk.catalogId,
                                    controller.produkModel?.data.data[index]
                                        .produk.kategoriId,
                                    controller.produkModel?.data.data[index]
                                        .produk.rakId,
                                    controller.produkModel?.data.data[index].id,
                                    controller
                                        .produkModel?.data.data[index].satuanId,
                                    controller.produkModel?.data.data[index]
                                        .hargaPokok,
                                    controller
                                        .produkModel?.data.data[index].hargaJual
                                        .toString(),
                                    controller.produkModel?.data.data[index]
                                        .diskonPersen,
                                    controller.produkModel?.data.data[index]
                                        .satuan.satuan,
                                    controller.produkModel?.data.data[index]
                                        .diskonStart,
                                    controller.produkModel?.data.data[index]
                                        .diskonEnd,
                                    controller
                                        .produkModel?.data.data[index].jamStart,
                                    controller
                                        .produkModel?.data.data[index].jamEnd,
                                    controller.produkModel?.data.data[index]
                                        .diskonHargaJual,
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '${controller.produkModel?.data.data[index].produk.nama}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${controller.produkModel?.data.data[index].satuan.satuan}',
                                            style: TextStyle(
                                              // fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            '${FormatUang.keIdr(controller.produkModel?.data.data[index].hargaJual.toInt(), 0)}',
                                            style: TextStyle(
                                              // fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                          // Column(
                                          //   children: [
                                          //     Text(''),
                                          //   ],
                                          // )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
              : Container(),
          controller.produkPageIndex == 1 &&
                  controller.totalDataProduk.value > controller.take.value
              ? controller.isLoadingTakeProduk == true
                  ? controller.isLoadingProduk == true
                      ? SizedBox()
                      : Center(
                          child: Container(
                            width: Get.width,
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                  : GestureDetector(
                      onTap: () {
                        controller.takeProdukLain();
                      },
                      child: Container(
                        width: Get.width,
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text("Lainnya"),
                        ),
                      ),
                    )
              : Container(),

          // produk custom
          controller.produkPageIndex == 2
              ? Container(
                  child: Expanded(
                    child: SingleChildScrollView(
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                'Nama produk',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              child: TextField(
                                controller: controller.cariProdukC,
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    controller.cariNamaProduk(value);
                                  } else if (value == '') {
                                    controller.fetchProduk();
                                  } else {
                                    controller.fetchProduk();
                                  }
                                },
                                // keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  // errorText: controller.validateUrl,
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.red),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.red),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(360),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Nama produk...',
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 10,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                'Harga ${controller.customHarga}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              child: TextField(
                                controller: controller.customHargaC,
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    if (value.isNumericOnly) {
                                      if (controller.customQty == 1) {
                                        controller.customHarga.value =
                                            int.parse(value);
                                        // controller.customTotalHarga = value;
                                        // RxInt(int.parse(value));
                                        print(controller.customTotalHarga);
                                      } else {
                                        controller.customHarga =
                                            RxInt(int.parse(value));
                                      }
                                    }
                                  }
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  // errorText: controller.validateUrl,
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.red),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.red),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(360),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Harga produk',
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 10,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Jumlah qty',
                                    style: TextStyle(
                                        fontSize: 18,
                                        // fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (controller.customQty > 1) {
                                            controller.customQty -= 1;
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(7),
                                          decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            ' - ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 45,
                                        child: Center(
                                          child: Text(
                                            '${controller.customQty}',
                                            style: TextStyle(
                                              fontSize: 19,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              // fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // var qty = controller.customQty += 1;
                                          // controller.customTotalHarga =
                                          //     controller.customHarga *
                                          //         controller.customQty;
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(7),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            ' + ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total harga",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    '${FormatUang.keIdr(controller.customTotalHarga.toInt(), 0)}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          controller.produkPageIndex == 2
              ? Container(
                  width: Get.width,
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text('Simpan'),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

class CartStorageWidget extends GetView<ModeKasirController> {
  const CartStorageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        reverse: true,
        itemCount:
            controller.cartStorage != null ? controller.cartStorage.length : 0,
        // itemCount: controller.cartItemData['data'] != null
        //     ? controller.cartItemData['data'].length
        //     : 0,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(controller.cartStorage[index].produkItemId.toString()),
            direction: DismissDirection.horizontal,
            confirmDismiss: (direction) async {
              controller
                  .deleteItemCart(controller.cartStorage[index].produkItemId);
              return true;
            },
            // onDismissed: (direction) {
            //   print('delete');
            //   // controller
            //   //     .deleteItemCart(controller.cartStorage[index].produkItemId);
            // },
            child: Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        // modalcart
                        controller.ubahHargaC.clear();
                        showModalBottomSheet(
                          context: context,
                          enableDrag: true,
                          isScrollControlled: true,
                          builder: (_) {
                            return Obx(
                              () => Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(50),
                                    topLeft: Radius.circular(20),
                                  ),
                                ),
                                height:
                                    MediaQuery.of(context).size.height / 1.07,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${controller.cartStorage[index].produkNama}',
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 5,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 5, 10, 5),
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Divider(thickness: 7),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Harga jual',
                                            style: TextStyle(
                                              fontSize: 19,
                                              // fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            '${FormatUang.keIdr(controller.cartStorage[index].hargaJual, 0)}',
                                            style: TextStyle(
                                              fontSize: 19,
                                              // fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Jumlah qty',
                                            style: TextStyle(
                                              fontSize: 19,
                                              // fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  controller.kurangQtyCart(
                                                      controller
                                                          .cartStorage[index]
                                                          .produkItemId);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(7),
                                                  decoration: BoxDecoration(
                                                    color: Colors.yellow,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Text(
                                                    ' - ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 30,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Container(
                                                width: 70,
                                                child: Center(
                                                  child: Text(
                                                    '${FormatUang.keNominal(controller.cartStorage[index].qty, 0)}',
                                                    style: TextStyle(
                                                      fontSize: 19,
                                                      // fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  controller.tambahQtyCart(
                                                      controller
                                                          .cartStorage[index]
                                                          .produkItemId);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(7),
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Text(
                                                    ' + ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 30,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Total harga jual',
                                            style: TextStyle(
                                              fontSize: 19,
                                              // fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            '${FormatUang.keIdr(controller.cartStorage[index].totalHargaJual, 0)}',
                                            style: TextStyle(
                                              fontSize: 19,
                                              // fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Potongan',
                                            style: TextStyle(
                                              fontSize: 19,
                                              // fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            '${FormatUang.keIdr(controller.cartStorage[index].potonganDiskon, 0)}',
                                            style: TextStyle(
                                              fontSize: 19,
                                              // fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Total harga',
                                            style: TextStyle(
                                              fontSize: 19,
                                              // fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            '${FormatUang.keIdr(controller.cartStorage[index].totalHarga, 0)}',
                                            style: TextStyle(
                                              fontSize: 19,
                                              // fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Harga Modal/Pokok',
                                            style: TextStyle(
                                              fontSize: 19,
                                              // fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            '${FormatUang.keIdr(controller.cartStorage[index].hargaModal, 0)}',
                                            style: TextStyle(
                                              fontSize: 19,
                                              // fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Ubah harga jual (Nego)',
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextField(
                                        keyboardType: TextInputType.number,
                                        autocorrect: true,
                                        controller: controller.ubahHargaC,
                                        onChanged: (val) {
                                          // print(val);
                                          if (val.isNumericOnly) {
                                            var harga_nego = val == null
                                                ? 0
                                                : double.parse(val);
                                            var harga_modal = controller
                                                        .cartStorage[index]
                                                        .hargaModal !=
                                                    null
                                                ? controller.cartStorage[index]
                                                    .hargaModal!
                                                    .toDouble()
                                                : 0;
                                            if (harga_modal < harga_nego) {
                                              controller.validateUbahHarga =
                                                  null;
                                              // jalankan
                                              controller.simpanUbahHarga(
                                                  controller.cartStorage[index]
                                                      .produkItemId,
                                                  harga_nego);
                                            } else {
                                              // print('under modal');
                                              controller.validateUbahHarga =
                                                  'Harga nego wajib diatas harga modal';
                                            }
                                            controller.fetchCart();
                                          } else {
                                            controller.validateUbahHarga =
                                                'Wajib angka';
                                          }
                                        },
                                        decoration: InputDecoration(
                                          errorText:
                                              controller.validateUbahHarga !=
                                                      null
                                                  ? controller.validateUbahHarga
                                                  : null,
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.red),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.red),
                                          ),
                                          fillColor: Colors.white60,
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            // borderSide: BorderSide.none,
                                          ),
                                          hintText: 'Harga nego',
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 14,
                                            horizontal: 10,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextButton.icon(
                                        onPressed: () {
                                          controller.deleteItemCart(controller
                                              .cartStorage[index].produkItemId);
                                          Get.back();
                                        },
                                        icon: Icon(Icons.delete,
                                            color: Colors.red),
                                        label: Text(
                                          'Hapus dari keranjang',
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      // InkWell(
                                      //   onTap: () {
                                      //     // simpanUbahHarga
                                      //   },
                                      //   child: Container(
                                      //     padding: EdgeInsets.all(15),
                                      //     decoration: BoxDecoration(
                                      //         color: Colors.green,
                                      //         borderRadius:
                                      //             BorderRadius.circular(5)),
                                      //     child: Center(
                                      //       child: Text(
                                      //         'Simpan',
                                      //         style: TextStyle(
                                      //           color: Colors.white,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      // onDoubleTap: () {
                      //   controller.deleteItemCart(
                      //       controller.cartStorage[index].produkItemId);
                      // },
                      hoverColor: Colors.black,
                      splashColor: Colors.black,
                      focusColor: Colors.black,
                      child: Container(
                        // color: Colors.blue,
                        padding: EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${controller.cartStorage[index].produkNama}',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                                // Text(
                                //   '${controller.cartItemData['data'][index]['produk']['nama']}',
                                // ),
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${FormatUang.keNominal(controller.cartStorage[index].qty, 0)}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      ' ${controller.cartStorage[index].satuan}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      ' x ',
                                    ),
                                    Text(
                                      '${FormatUang.keNominal(controller.cartStorage[index].hargaJual, 0)}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      ' = ',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    // Text(
                                    //   '${FormatUang.keNominal(double.parse(controller.cartItemData['data'][index]['qty']), 0)}',
                                    //   style: TextStyle(
                                    //       fontWeight:
                                    //           FontWeight.w500),
                                    // ),
                                    // Text(
                                    //   ' ${controller.cartItemData['data'][index]['satuan']['satuan']}',
                                    // ),
                                    // Text(' x '),
                                    // Text(
                                    //   '${FormatUang.keNominal(double.parse(controller.cartItemData['data'][index]['harga_jual']), 0)}',
                                    // ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    // Text(
                                    //   '${FormatUang.keIdr(double.parse(controller.cartItemData['data'][index]['total_harga_jual']), 0)}',
                                    //   style: TextStyle(
                                    //     fontWeight: FontWeight.w500,
                                    //   ),
                                    // )

                                    Text(
                                      '${FormatUang.keNominal(controller.cartStorage[index].totalHargaJual, 0)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    // color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 2,
                        ),
                        InkWell(
                          onTap: () {
                            controller.kurangQtyCart(
                                controller.cartStorage[index].produkItemId);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 9, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              ' - ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),

                        InkWell(
                          onTap: () {
                            controller.tambahQtyCart(
                                controller.cartStorage[index].produkItemId);
                          },
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              ' + ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 5,
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     controller.deleteItemCart(
                        //         controller.cartStorage[index].produkItemId);
                        //   },
                        //   child: Container(
                        //     padding: EdgeInsets.all(3),
                        //     decoration: BoxDecoration(
                        //       color: Colors.redAccent,
                        //       borderRadius: BorderRadius.circular(5),
                        //     ),
                        //     child: Icon(
                        //       Icons.delete_outline,
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PageSheetHeader extends GetView<ModeKasirController> {
  const PageSheetHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.fromLTRB(8, 8, 8, 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.shopping_cart_sharp),
                // Text(
                //   'Keranjang',
                //   style: TextStyle(
                //     fontWeight: FontWeight.w500,
                //     fontSize: 15,
                //   ),
                // ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "${controller.total_item} Produk",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(
                  width: 5,
                ),
              ],
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed('/bill-penjualan/${controller.kasirid}');
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        'Bill (${controller.jmlBill})',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    controller.removeAllcartStorage();
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(17, 10, 17, 10),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PageSheetFooter extends GetView<ModeKasirController> {
  const PageSheetFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Subtotal",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "${FormatUang.keIdr(controller.subtotal.toDouble(), 0)}",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Potongan",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "${FormatUang.keIdr(controller.potongan.toDouble(), 0)}",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total bayar",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "${FormatUang.keIdr(controller.total_bayar.toDouble(), 0)}",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Column(
                  children: [
                    controller.billID.isEmpty
                        ? InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => SimpanBillPage(),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                  'Simpan Bill',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              controller.perbaruiBill(controller.billID);
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Perbarui bill',
                                style: TextStyle(
                                    // color: Colors.white,
                                    ),
                              ),
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // modalbayar
                      controller.inputKembaliC.clear();
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) {
                          return PembayaranPage();
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          'Bayar',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SimpanBillPage extends GetView<ModeKasirController> {
  const SimpanBillPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        height: MediaQuery.of(context).size.height / 1.09,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: double.maxFinite,
              color: Colors.green,
              child: Center(
                child: Text(
                  'Simpan Bill',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Nama pelanggan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                controller: controller.namaPelangganC,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    controller.namaPelanggan(value);
                  }
                },
                keyboardType: TextInputType.name,
                maxLength: 30,
                decoration: InputDecoration(
                  // errorText: controller.validateSimpanBill,
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(width: 1, color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(width: 1, color: Colors.red),
                  ),
                  fillColor: Colors.black12,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Nama pelanggan...',
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 10,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            controller.namaPelanggan.isEmpty
                ? Container()
                : controller.loadingSimpanBill.value != true
                    ? InkWell(
                        onTap: () {
                          if (controller.namaPelanggan.isEmpty) {
                          } else {
                            controller.simpanBill();
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          padding: EdgeInsets.all(9),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.blue),
                          child: Center(
                            child: Text(
                              'Simpan bill',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          padding: EdgeInsets.all(9),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.blue),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}

class PembayaranPage extends GetView<ModeKasirController> {
  const PembayaranPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        // padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        height: MediaQuery.of(context).size.height / 1.04,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.green, boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 3,
                  color: Colors.black26,
                ),
              ]),
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 11, 10, 11),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pembayaran',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(color: Colors.green[50]),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      '${FormatUang.keIdr(controller.total_bayar.toDouble(), 0)}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Center(
                    child: Text(
                      'Uang : ${FormatUang.keIdr(controller.diterima.value, 0)}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Center(
                    child: Text(
                      'Kembali : ${FormatUang.keIdr(controller.kembali.toDouble(), 0)}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.black12,
                              isScrollControlled: true,
                              enableDrag: true,
                              builder: (context) {
                                return PilihPelanggan();
                              },
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.green),
                            child: Center(
                              child: Text(
                                '${controller.pelanggan_id.value != null ? controller.pelanggan_nama.value : 'Pilih pelanggan'}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            'Pilih pembayaran',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            'Tunai',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: WidgetBtnNominal(),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              // transaksi
                              controller.inputKembaliC.clear();
                              controller
                                  .btnNominal(controller.total_bayar.toInt());
                              // print('object');
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.green),
                              child: Center(
                                child: Text(
                                  'Uang pas',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            autocorrect: true,
                            controller: controller.inputKembaliC,
                            onChanged: (val) {
                              if (val.isNumericOnly) {
                                var kembali = val == null ? 0 : val;
                                controller.diterima.value = int.parse(val);
                                controller.kembali.value = int.parse(val) -
                                    controller.total_bayar.value;
                                controller.fetchCart();
                              } else {
                                print('huruf');
                              }
                            },
                            decoration: InputDecoration(
                              // errorText: controller
                              //             .validateUbahHarga !=
                              //         null
                              //     ? controller.validateUbahHarga
                              //     : null,
                              // errorBorder: OutlineInputBorder(
                              //   borderRadius:
                              //       BorderRadius.circular(30),
                              //   borderSide: const BorderSide(
                              //       width: 1, color: Colors.red),
                              // ),
                              // focusedErrorBorder:
                              //     OutlineInputBorder(
                              //   borderRadius:
                              //       BorderRadius.circular(30),
                              //   borderSide: const BorderSide(
                              //       width: 1, color: Colors.red),
                              // ),
                              fillColor: Colors.white60,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                // borderSide: BorderSide.none,
                              ),
                              hintText: 'Uang di Terima',
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        controller.loadingTransaksi != true
                            ? Expanded(
                                child: InkWell(
                                  onTap: () {
                                    controller.simpanTransaksi();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(13),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.blue),
                                    child: Center(
                                      child: Text(
                                        'Simpan',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: InkWell(
                                  onTap: () {
                                    // controller.simpanTransaksi();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(13),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.blue),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Divider(
                    thickness: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            'Non tunai (blm ada)',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    thickness: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            'Bayar nanti (utang / cod)',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (controller.pelanggan_id.value == null) {
                              Get.defaultDialog(
                                  title: 'Pilih Pelanggan!',
                                  middleText:
                                      'Bayar nanti harus pilih pelanggan dulu',
                                  textCancel: '  Oke  ');
                            } else {
                              controller.bayarNanti();
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.red),
                            child: Center(
                              child: Text(
                                'Bayar nanti',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 250,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PilihPelanggan extends StatelessWidget {
  const PilihPelanggan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.green, boxShadow: [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: 3,
                color: Colors.black26,
              ),
            ]),
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 11, 10, 11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pilih pelanggan',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageSheet extends GetView<ModeKasirController> {
  const PageSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        height: MediaQuery.of(context).size.height / 1.07,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageSheetHeader(),
            Divider(
              color: Colors.black,
            ),
            Expanded(
              child: Container(
                child: CartStorageWidget(),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            PageSheetFooter(),
          ],
        ),
      ),
    );
  }
}

Widget nominalWidget(context, nominal) {
  final controller = Get.find<ModeKasirController>();
  return InkWell(
    splashColor: Colors.green,
    highlightColor: Colors.green,
    onTap: () {
      controller.inputKembaliC.clear();
      controller.btnNominal(nominal);
    },
    child: Container(
      padding: MediaQuery.of(context).size.width <= 600.0
          ? EdgeInsets.fromLTRB(15, 12, 15, 12)
          : EdgeInsets.fromLTRB(15, 10, 15, 10),
      margin: EdgeInsets.only(right: 6, bottom: 3),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        '${FormatUang.keNominal(nominal, 0)}',
        style: TextStyle(
          fontSize: 17,
          color: Colors.black,
        ),
      ),
    ),
  );
}
