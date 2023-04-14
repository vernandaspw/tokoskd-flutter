import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoskd/app/core/helpers/FormatUang.dart';

import 'bill_penjualan_controller.dart';

class BillPenjualanPage extends GetView<BillPenjualanController> {
  const BillPenjualanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill Menu'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Obx(
        () => controller.loadingBill == true
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              )
            : Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: RefreshIndicator(
                    onRefresh: () async {
                      return controller.getBill();
                    },
                    child: ListView.builder(
                      itemCount: controller.dataBill.length,
                      itemBuilder: (context, index) => Dismissible(
                        key: Key(controller.dataBill[index]['id'].toString()),
                        direction: DismissDirection.horizontal,
                        confirmDismiss: (direction) async {
                          controller
                              .deleteBill(controller.dataBill[index]['id']);
                          // if (controller.deleteSuccess == true) {
                          return true;
                          // }
                        },
                        child: InkWell(
                          onTap: () async {
                            // controller
                            //     .prosesBill(controller.dataBill[index]['id']);

                            Get.toNamed(
                                '/bill-detail/${controller.dataBill[index]['id']}/${controller.kasirID}');
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3,
                                  color: Colors.black26,
                                )
                              ],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        '${controller.dataBill[index]['created_at_human']}'),
                                    Text(
                                        '(${controller.dataBill[index]['bill_item'].length} item) ${controller.dataBill[index]['no_bill']}'),
                                  ],
                                ),
                                Divider(height: 7),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Nama Pel'),
                                    Text(
                                        '${controller.dataBill[index]['pelanggan_nama']}'),
                                  ],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Total pembayaran'),
                                    Text(
                                        '${FormatUang.keIdr(double.parse(controller.dataBill[index]['total_pembayaran']), 0)} '),
                                  ],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Dibuat oleh'),
                                    Text(
                                        '${controller.dataBill[index]['user'] != null ? controller.dataBill[index]['user']['nama'] : '-'}'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ))
                ],
              ),
      ),
    );
  }
}
