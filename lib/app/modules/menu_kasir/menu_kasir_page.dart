import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoskd/app/core/helpers/FormatUang.dart';

import 'menu_kasir_controller.dart';

class MenuKasirPage extends GetView<MenuKasirController> {
  const MenuKasirPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Menu kasir'),
        actions: [
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              onPressed: () {
                print('info laporan');
              },
              child: Text(
                'Laporan kasir',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getRole();
          controller.getKasir();
        },
        child: SafeArea(
          child: Obx(
            () => Container(
              margin: EdgeInsets.fromLTRB(8, 10, 8, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Pilih kasir',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  controller.loadingKasir == true
                      ? CircularProgressIndicator(
                          color: Colors.blue,
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: controller.kasirModel != null
                                ? controller.kasirModel?.data.length
                                : 0,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  if (controller
                                          .kasirModel?.data[index].status ==
                                      'open') {
                                    Get.offNamed(
                                        '/mode-kasir/${controller.kasirModel?.data[index].id}');
                                  } else if (controller
                                          .kasirModel?.data[index].status ==
                                      'pending') {
                                    Get.defaultDialog(
                                      title: "PENDING",
                                      middleText:
                                          'Menunggu konfirmasi diterima di laporan',
                                      textConfirm: 'Oke',
                                      buttonColor: Colors.yellow,
                                      confirmTextColor: Colors.white,
                                      onConfirm: () {
                                        Get.back();
                                      },
                                    );
                                  } else {
                                    Get.defaultDialog(
                                      backgroundColor: Colors.redAccent,
                                      titleStyle:
                                          TextStyle(color: Colors.white),
                                      title:
                                          "${controller.kasirModel?.data[index].nama} Tutup",
                                      middleTextStyle:
                                          TextStyle(color: Colors.white),
                                      middleText:
                                          'Silahkan buka kas kasir terlebih dahulu',
                                      buttonColor: Colors.green,
                                      cancelTextColor: Colors.white,
                                      textCancel: '  Oke  ',
                                    );
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(15, 5, 15, 8),
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                  decoration: BoxDecoration(
                                    color: controller.kasirModel?.data[index]
                                                .status ==
                                            'pending'
                                        ? Colors.yellow
                                        : Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 30,
                                        color: Colors.black26,
                                        offset: Offset(0, 7),
                                        spreadRadius: 0.1,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Text(
                                              '${controller.kasirModel?.data[index].nama} | ${controller.kasirModel?.data[index].status}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              controller.kasirModel?.data[index]
                                                          .status ==
                                                      'open'
                                                  ? ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.red,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Get.toNamed(
                                                            '/tutup-kas-kasir/${controller.kasirModel?.data[index].id}');
                                                      },
                                                      child: Text('Tutup kas'),
                                                    )
                                                  : SizedBox(),
                                              controller.role == 'superadmin' ||
                                                      controller.role == 'admin'
                                                  ? controller
                                                              .kasirModel
                                                              ?.data[index]
                                                              .status ==
                                                          'pending'
                                                      ? ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.green,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          3),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            Get.toNamed(
                                                                '/kasir-terima-kas/${controller.kasirModel?.data[index].id}');
                                                          },
                                                          child: Text(
                                                              'Terima kas'),
                                                        )
                                                      : SizedBox()
                                                  : SizedBox(),
                                              controller.kasirModel?.data[index]
                                                          .status ==
                                                      'close'
                                                  ? ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.blueAccent,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Get.defaultDialog(
                                                          title:
                                                              "Buka kas ${controller.kasirModel?.data[index].nama}",
                                                          middleText:
                                                              'Saldo awal : ${FormatUang.keIdr(double.parse(controller.kasirModel!.data[index].kas.saldo), 0)}',
                                                          textConfirm: 'Simpan',
                                                          buttonColor:
                                                              Colors.green,
                                                          confirmTextColor:
                                                              Colors.white,
                                                          onConfirm: () {
                                                            controller.LoadingModeKasir ==
                                                                    false
                                                                ? controller.bukaKasKasir(
                                                                    controller
                                                                        .kasirModel
                                                                        ?.data[
                                                                            index]
                                                                        .id)
                                                                : null;
                                                          },
                                                          textCancel: 'Batal',
                                                        );
                                                      },
                                                      child: Text(
                                                        'Buka kas',
                                                        style: TextStyle(),
                                                      ),
                                                    )
                                                  : SizedBox(),
                                            ],
                                          )
                                        ],
                                      ),
                                      Divider(),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${FormatUang.keIdr(double.parse(controller.kasirModel!.data[index].kas.saldo), 0)}',
                                        style: TextStyle(
                                          fontSize: 22,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Selisih ${FormatUang.keIdr(double.parse(controller.kasirModel!.data[index].kas.saldoSelisih), 0)}',
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          controller.kasirModel?.data[index]
                                                      .status ==
                                                  'open'
                                              ? Row(
                                                  children: [
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.blueAccent,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Get.toNamed(
                                                            '/kasir-kas-masuk/${controller.kasirModel?.data[index].id}');
                                                      },
                                                      child: Text('kas masuk'),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.yellow,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Get.toNamed(
                                                            '/kasir-kas-keluar/${controller.kasirModel?.data[index].id}');
                                                      },
                                                      child: Text(
                                                        'kas keluar',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : SizedBox(
                                                  height: 50,
                                                )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
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
