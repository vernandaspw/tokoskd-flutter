import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:get/get.dart';

class TesPrintThermalController extends GetxController {
  //TODO: Implement TesPrintThermalController.
  List<BluetoothDevice> devices = [];
  BluetoothDevice? selectedDevice;
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  @override
  void onInit() {
    super.onInit();
    getDevice();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getDevice() async {
    devices = await printer.getBondedDevices();
    print('terhubung');
    // Get.defaultDialog(middleText: devices.toString());
  }
}
