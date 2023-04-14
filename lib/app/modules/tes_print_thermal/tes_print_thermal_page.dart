import 'dart:convert';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TesPrintThermalPage extends StatefulWidget {
  const TesPrintThermalPage({super.key});

  @override
  State<TesPrintThermalPage> createState() => _TesPrintThermalPageState();
}

class _TesPrintThermalPageState extends State<TesPrintThermalPage> {
  List<BluetoothDevice> devices = [];
  BluetoothDevice? selectedDevice;
  BlueThermalPrinter printer = BlueThermalPrinter.instance;
  bool connected = false;
  bool isOn = false;

  var deviceSaya = '';
  var isConn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDevice();
  }

  void getDevice() async {
    // Get.defaultDialog(middleText: devices.toString());
    devices = await printer.getBondedDevices();
    printer.isConnected.then((value) {
      isConn = value!;
    });
    // printer.connect(devices.first);
    // printer.connect(devices.last);
    setState(() {});
  }

  getPrinters() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = prefs.getStringList('printerSaya') ?? [];

    print(itemsJson);
    // await prefs.setStringList('printerSaya', itemsJson);
    // return items;
  }

  Future<void> savePrinters(List<dynamic> printers) async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson =
        printers.map((item) => json.encode(item.toJson())).toList();
    await prefs.setStringList('printerSaya', itemsJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tes Print Page'),
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
        backgroundColor: isConn == false ? Colors.red : Colors.white,
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              getDevice();
            });
          },
          child: Container(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),

                Text(
                  isConn == true ? 'Terhubung' : 'Sedang tidak terhubung',
                  style: TextStyle(
                    color: isConn == true ? Colors.black : Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  isConn == true
                      ? 'silahkan refresh / tes print'
                      : 'Pilih device klik sampe backgroud putih',
                  style: TextStyle(
                    fontSize: 20,
                    color: isConn == true ? Colors.black : Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 280,
                  child: ListView.builder(
                    itemCount: devices.length > 0 ? devices.length : 0,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          // BluetoothDevice select = devices[0];
                          // BluetoothDevice select = devices[index];
                          // List list = select.split("#");
                          // String name = list[0];
                          // String mac = list[1];
                          // this.setConnect(mac);

                          // try {
                          //   printer.disconnect();
                          // } finally {
                          //   printer.connect(devices[index]);
                          // }

                          // print();

                          setState(() async {
                            if (isConn == true) {
                              print('ok');
                              printer.disconnect();
                              this.getDevice();
                            } else {
                              print('masalah');
                              printer.connect(devices[index]).then((value) {
                                // print(value.toString());
                              });
                              var data = devices[index].toMap();
                              print(data);
                              final prefs =
                                  await SharedPreferences.getInstance();
                              final itemsJson = devices
                                  .map((item) => json.encode(item))
                                  .toList();
                              // print(devices[index]));
                              // prefs.setString('printers', data);
                              this.getDevice();
                            }
                            getDevice();
                          });
                          this.getDevice();
                        },
                        title: Row(
                          children: [
                            Text(
                              '${devices[index].name} - ${devices[index].address}',
                              style: TextStyle(
                                color: isConn == true
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          "Klik untuk connect",
                          style: TextStyle(
                            color: isConn == true ? Colors.black : Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                // DropdownButton<BluetoothDevice>(
                //   hint: Text('select thermal printer'),
                //   value: selectedDevice,
                //   onChanged: (device) {
                //     selectedDevice = device;
                //   },
                //   items: devices
                //       .map(
                //         (e) => DropdownMenuItem(
                //           child: Text(e.name!),
                //           value: e,
                //         ),
                //       )
                //       .toList(),
                // ),
                // ElevatedButton(
                //   onPressed: () async {

                //     printer.connect(printer.connect(devices.address));
                //   },
                //   child: Text('connect'),
                // ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          onPressed: () async {
                            setState(() {
                              this.getDevice();
                            });
                          },
                          child: Text('Refresh'),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                isConn == true
                    ? Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(),
                                    onPressed: () async {
                                      setState(() {
                                        getDevice();
                                      });

                                      // printer.printCustom('TOKO SKD', 2, 1);
                                      // printer.printCustom('14:00, 11/03/2023', 0, 1);
                                      // printer.printLeftRight('No order', '54345435435345', 0);
                                      // printer.printLeftRight('Pelanggan', '-', 0);
                                      // printer.printLeftRight('Kasir', 'admin', 0);
                                      printer.write(
                                          '================================');
                                      printer.printCustom(
                                          'PRINT BERHASIL', 1, 1);
                                      printer.write(
                                          '================================');
                                      // printer.printCustom(
                                      //     'Beng beng besar sari roti (pcs)', 1, 0);
                                      // printer.printLeftRight('2 x 10.000', '20.000', 0);
                                      // printer.printCustom('Tim tam (kardus)', 1, 0);
                                      // printer.printLeftRight('2 x 10.000 ', '(p) 20.000', 0);
                                      // printer.write('================================');
                                      // printer.printLeftRight('Subtotal', 'Rp. 3000.000', 0);
                                      // printer.printLeftRight('potongan', 'Rp. 100.000', 0);
                                      // printer.printNewLine();
                                      // printer.printLeftRight('Total Bayar', 'Rp. 2.900.000', 1);
                                      // printer.printLeftRight('bayar', 'Rp. 3.200.000', 0);
                                      // printer.printLeftRight('Kembali', 'Rp. 3.00.000', 0);
                                      // printer.write('================================');
                                      // printer.printCustom('Struk berlaku 1x24 jam', 0, 1);
                                      // printer.printCustom('~Terima kasih~', 0, 1);
                                      // printer.printNewLine();
                                      printer.printNewLine();
                                      printer.printNewLine();
                                      printer.printNewLine();
                                      printer.printNewLine();
                                      printer.paperCut();
                                    },
                                    child: Text('Tes print'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.deepOrange),
                                    onPressed: () async {
                                      setState(() {
                                        printer.disconnect();
                                        getDevice();
                                      });
                                    },
                                    child: Text('Disconnect'),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    : SizedBox()
              ],
            ),
          ),
        ));
  }
}

// class TesPrintThermalPage extends GetView<TesPrintThermalController> {
//   const TesPrintThermalPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('TesPrintPage'),
//         centerTitle: true,
//       ),
//       body: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Search Paired Bluetooth"),
//             TextButton(
//               onPressed: () {
//                 controller.getDevice();
//               },
//               child: Text("Search"),
//             ),
//             Text(
//               '${controller.devices.length > 0 ? controller.devices.length : 0}',
//             ),

//             Container(
//               height: 200,
//               child: ListView.builder(
//                 itemCount: controller.devices.length > 0
//                     ? controller.devices.length
//                     : 0,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     onTap: () {
//                       // BluetoothDevice select = controller.devices[index];
//                       // List list = select.split("#");
//                       // // String name = list[0];
//                       // String mac = list[1];
//                       // this.setConnect(mac);
//                     },
//                     title: Text(
//                         'cek ${controller.devices[index].name} - ${controller.devices[index].connected}'),
//                     subtitle: Text("Click to connect"),
//                   );
//                 },
//               ),
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             // DropdownButton<BluetoothDevice>(
//             //   hint: Text('select thermal printer'),
//             //   value: controller.selectedDevice,
//             //   onChanged: (device) {
//             //     controller.selectedDevice = device;
//             //   },
//             //   items: controller.devices
//             //       .map(
//             //         (e) => DropdownMenuItem(
//             //           child: Text(e.name!),
//             //           value: e,
//             //         ),
//             //       )
//             //       .toList(),
//             // ),
//             ElevatedButton(
//               onPressed: () async {
//                 controller.printer.connect(controller.selectedDevice!);
//               },
//               child: Text('connect'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 controller.printer.disconnect();
//               },
//               child: Text('disconnect'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 if ((await controller.printer.isConnected)!) {
//                   controller.printer.printNewLine();
//                   controller.printer.printCustom('tes', 0, 1);
//                   controller.printer.printQRcode('tes', 200, 200, 1);
//                 } else {
//                   print('not connect');
//                 }
//               },
//               child: Text('print'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
