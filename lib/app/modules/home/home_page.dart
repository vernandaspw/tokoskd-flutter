import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokoskd/app/core/helpers/FormatUang.dart';
import 'package:tokoskd/app/core/theme/tema.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Apakah Anda yakin ingin keluar?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('YA'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Tidak'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            title: const Text('Toko SKD'),
            backgroundColor: Colors.green,
            centerTitle: true,
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              // controller.getMe();
              controller.refresh();
              controller.getRole();
              controller.getPrinter();
            },
            child: SingleChildScrollView(
              child: controller.pageIndex == 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Hallo, ${controller.nama != null ? controller.nama : null}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'IP Address : ${controller.url != null ? controller.url : null}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.print),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${controller.siapPrint == true ? 'Printer terhubung' : 'printer tidak aktif'}',
                                        style: TextStyle(
                                          color: controller.siapPrint == true
                                              ? Colors.green
                                              : Colors.red,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.getMe();
                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          child: Text(
                                            'Cek IP',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed('/ubah-ip');
                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          child: Text(
                                            'Ubah IP',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Tema.enter8,
                        // Quick(),
                        // Tema.enter8,
                        Penjualan(),
                        Tema.enter8,
                        Pembelian(),
                        Tema.enter8,
                        Produk(),
                        Tema.enter8,
                        controller.role == 'superadmin' ||
                                controller.role == 'admin'
                            ? Keuangan()
                            : SizedBox(),
                        Tema.enter8,
                        controller.role == 'superadmin' ||
                                controller.role == 'admin'
                            ? SDM()
                            : SizedBox(),
                        Tema.enter8,
                        Master(),
                        Tema.enter8,
                        Tema.enter8,
                        Tema.enter8,
                      ],
                    )
                  : Column(
                      children: [
                        Akun(controller: controller),
                      ],
                    ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // controller.getKasir();
              // showModalBottomSheet(
              //   isScrollControlled: true,
              //   context: context,
              //   builder: ((context) {
              //     return PageSheet();
              //   }),
              // );
              Get.toNamed('/menu-kasir');
            },
            child: Icon(Icons.point_of_sale),
            backgroundColor: Colors.green,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    controller.pageIndex.value = 0;
                  },
                ),
                controller.role == 'superadmin'
                    ? IconButton(
                        icon: Icon(Icons.bar_chart),
                        onPressed: () {
                          controller.pageIndex.value = 0;
                        },
                      )
                    : SizedBox(),
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    controller.pageIndex.value = 1;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class PageSheet extends GetView<HomeController> {
//   const PageSheet({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         height: MediaQuery.of(context).size.height / 1.2,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         'Pilih kasir',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 23,
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.cyan,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         onPressed: () {
//                           print('info laporan');
//                         },
//                         child: Text('Laporan kasir'),
//                       ),
//                     ],
//                   ),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                     ),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Icon(Icons.close),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: controller.kasirModel != null
//                     ? controller.kasirModel?.data.length
//                     : 0,
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                     onTap: () {
//                       Get.toNamed(
//                           '/mode-kasir/:${controller.kasirModel?.data[index].id}');
//                     },
//                     child: Container(
//                       padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             // crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.all(4),
//                                 child: Text(
//                                   '${controller.kasirModel?.data[index].nama}',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 20,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               // ElevatedButton(
//                               //   style: ElevatedButton.styleFrom(
//                               //     backgroundColor: Colors.red,
//                               //     shape: RoundedRectangleBorder(
//                               //       borderRadius: BorderRadius.circular(10),
//                               //     ),
//                               //   ),
//                               //   onPressed: () {
//                               //     print('cek');
//                               //   },
//                               //   child: Text('Buka kas'),
//                               // ),
//                               ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.red,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                                 onPressed: () {
//                                   print('cek');
//                                 },
//                                 child: Text('Tutup kas'),
//                               )
//                             ],
//                           ),
//                           Divider(),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Text(
//                             '${FormatUang.keIdr(double.parse(controller.kasirModel!.data[index].kas.saldo), 0)}',
//                             style: TextStyle(
//                               fontSize: 22,
//                               color: Colors.white,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Text(
//                             'Selisih ${FormatUang.keIdr(double.parse(controller.kasirModel!.data[index].kas.saldoSelisih), 0)}',
//                             style: TextStyle(
//                               fontSize: 17,
//                               color: Colors.white,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Row(
//                                 children: [
//                                   ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.blueAccent,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                     ),
//                                     onPressed: () {
//                                       print('cek');
//                                     },
//                                     child: Text('kas masuk'),
//                                   ),
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.yellow,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                     ),
//                                     onPressed: () {
//                                       print('cek');
//                                     },
//                                     child: Text(
//                                       'kas keluar',
//                                       style: TextStyle(color: Colors.black),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class Quick extends StatelessWidget {
  const Quick({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                'Quick',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Tema.enter8,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Get.toNamed('/penjualan');
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.arrow_circle_up_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Absen masuk",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    // Get.toNamed('/penjualan');
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.arrow_circle_up_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Absen keluar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    // Get.toNamed('/penjualan');
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Riwayat absen",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    // Get.toNamed('/penjualan');
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Kalendar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    // Get.toNamed('/penjualan-retur');
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.monetization_on_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Gajian",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Penjualan extends GetView<HomeController> {
  const Penjualan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                'Penjualan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Tema.enter8,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    // controller.getKasir();
                    // showModalBottomSheet(
                    //   isScrollControlled: true,
                    //   context: context,
                    //   builder: ((context) {
                    //     return PageSheet();
                    //   }),
                    // );
                    // Get.toNamed('/tes-print-thermal');
                    // controller.getPrinter();

                    if (controller.siapPrint == true) {
                      controller.printer
                          .write('================================');
                      controller.printer
                          .printCustom('${controller.printAddress}', 3, 1);
                      controller.printer
                          .write('================================');

                      controller.printer.printNewLine();
                      controller.printer.printNewLine();
                      controller.printer.printNewLine();
                      controller.printer.paperCut();
                    } else {
                      controller.getPrinter();
                      // print('ce');
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.print,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "tes print",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    // controller.getKasir();
                    // showModalBottomSheet(
                    //   isScrollControlled: true,
                    //   context: context,
                    //   builder: ((context) {
                    //     return PageSheet();
                    //   }),
                    // );
                    Get.toNamed('/menu-kasir');
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.point_of_sale,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Kasir",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    // Get.toNamed('/penjualan');
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.sell,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Penjualan",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    // Get.toNamed('/penjualan-retur');
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.assignment_returned,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Retur penjualan",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Pembelian extends StatelessWidget {
  const Pembelian({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                'Pembelian',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Tema.enter8,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Get.toNamed('/pembelian-pesanan');
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.note_add,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Pesanan pembelian",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    // Get.toNamed('/pembelian');
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.shopping_basket_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Pembelian",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    // Get.toNamed('/pembelian-retur');
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.outbox_sharp,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Retur pembelian",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Produk extends GetView<HomeController> {
  const Produk({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                'Produk',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Tema.enter8,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Get.toNamed('/produk-item');
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.kitchen,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Produk",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    // Get.toNamed('/produk-stok');
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.note_alt_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Stok",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                controller.role == 'superadmin' || controller.role == 'admin'
                    ? GestureDetector(
                        onTap: () {
                          // Get.toNamed('/produk-diskon');
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.discount,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Diskon",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    // Get.toNamed('/produk-opname');
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.list_alt_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Opname",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Keuangan extends StatelessWidget {
  const Keuangan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                'Keuangan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Tema.enter8,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Get.toNamed('/produk-item');
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.account_balance,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Kas",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    // Get.toNamed('/produk-stok');
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.bookmark_add_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Piutang usaha",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/produk-diskon');
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.bookmark_remove_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Hutang usaha",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SDM extends StatelessWidget {
  const SDM({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                'SDM',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Tema.enter8,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Get.toNamed('/produk-item');
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.account_circle,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Akun",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    // Get.toNamed('/produk-item');
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.contact_mail,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Karyawan",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    // Get.toNamed('/produk-stok');
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.calendar_month_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Data jadwal",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    // Get.toNamed('/produk-diskon');
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.access_time_filled_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Absensi",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    // Get.toNamed('/produk-diskon');
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.payments_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Data gaji",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Master extends GetView<HomeController> {
  const Master({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                'Master',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Tema.enter8,
          Wrap(
            spacing: 2,
            direction: Axis.horizontal,
            runSpacing: 8,
            children: [
              GestureDetector(
                onTap: () {
                  // Get.toNamed('/produk-diskon');
                },
                child: Container(
                  width: 115,
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.man,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Pelanggan",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              controller.role == 'superadmin' || controller.role == 'admin'
                  ? GestureDetector(
                      onTap: () {
                        // Get.toNamed('/produk-diskon');
                      },
                      child: Container(
                        width: 115,
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.business,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Supplier",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                width: 5,
              ),
              controller.role == 'superadmin' || controller.role == 'admin'
                  ? GestureDetector(
                      onTap: () {
                        // Get.toNamed('/produk-stok');
                      },
                      child: Container(
                        width: 115,
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.add_business,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Toko",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  // Get.toNamed('/produk-stok');
                },
                child: Container(
                  width: 115,
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.one_k,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Satuan",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  // Get.toNamed('/produk-stok');
                },
                child: Container(
                  width: 115,
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.branding_watermark_sharp,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Merek",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  // Get.toNamed('/produk-stok');
                },
                child: Container(
                  width: 115,
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.apps_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Catalog",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  // Get.toNamed('/produk-stok');
                },
                child: Container(
                  width: 115,
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.category,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Kategori",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  // Get.toNamed('/produk-stok');
                },
                child: Container(
                  width: 115,
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.table_chart,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Rak",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Akun extends StatelessWidget {
  const Akun({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                'Akun',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Tema.enter8,
          GestureDetector(
            onTap: () async {
              final shouldPop = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Apakah yakin ingin logout?'),
                    actionsAlignment: MainAxisAlignment.spaceBetween,
                    actions: [
                      TextButton(
                        onPressed: () {
                          controller.logout();
                        },
                        child: const Text(
                          'YA',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text('Tidak'),
                      ),
                    ],
                  );
                },
              );
              // return shouldPop!;
            },
            child: Container(
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
