import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokoskd/app/core/config/api.dart';
import 'package:tokoskd/app/data/models/ModeKasir/ModeKasirProdukModel.dart';
import 'package:tokoskd/app/data/models/ModeKasir/model_produk_mode_kasir/model_produk_mode_kasir.dart';
import 'package:tokoskd/app/data/sessions/Cart.dart';
import 'package:tokoskd/app/data/sessions/session.dart';
import 'package:tokoskd/app/modules/bill_penjualan/bill_penjualan_controller.dart';

class ModeKasirController extends GetxController {
  //TODO: Implement ModeKasirController.
  late TextEditingController inputKembaliC;
  late TextEditingController cariProdukC;
  late TextEditingController ubahHargaC;
  late TextEditingController customHargaC;
  late TextEditingController namaPelangganC;

  var id = 0.obs;

  var barcode = ''.obs;
  var produkPageIndex = 1.obs;

  // var totalBelanja = 67000.obs;

  // var produkData = {}.obs;
  ModeKasirProdukModel? produkModel = ModeKasirProdukModel.obs;
  var cartItemData = {}.obs;

  var isLoadingProduk = false.obs;
  var isLoadingTakeProduk = false.obs;
  var take = 20.obs;
  RxInt totalDataProduk = 0.obs;

  var animasi = false.obs;

  var customHarga = 0.obs;
  var customQty = 1.obs;
  var customTotalHarga = 0.obs;

  var kasirid = ''.obs;

  @override
  void onInit() {
    super.onInit();
    inputKembaliC = new TextEditingController();
    cariProdukC = new TextEditingController();
    ubahHargaC = new TextEditingController();
    customHargaC = new TextEditingController();
    namaPelangganC = new TextEditingController();

    getBill();

    fetchProduk();
    fetchCart();

    // Get parameters
    kasirid.value = Get.parameters['kasirid'].toString();
    kasirLogMasuk(kasirid);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    inputKembaliC.dispose();
    cariProdukC.dispose();
    ubahHargaC.dispose();
    customHargaC.dispose();
    namaPelangganC.dispose();
  }

  // MASUK LOG KASIR
  void kasirLogMasuk(kasir_id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final String? url = prefs.getString('url');
      var dataUrl = 'http://$url/api/';

      var response = await Api.client.post(
        Uri.parse(
          '${dataUrl}modekasir/kasir-log-masuk',
        ),
        headers: {
          'Authorization': 'Bearer ${token}',
        },
        body: {
          'kasir_id': kasir_id.toString(),
        },
      );

      if (response.statusCode == 200) {
        // var res = json.decode(response.body);
        // jika berhasil go page mode kasir dengan beri parameter ID kasir
        // Get.offNamed('/mode-kasir/${kasir_id.toString()}');
        print('success');
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  void animasiStart() async {
    animasi(true);
  }

  void animasiEnd() async {
    Future.delayed(Duration(seconds: 100));
    animasi(false);
  }

  void produkBaru() {
    produkPageIndex.value = 0;
  }

  void produkLama() async {
    produkPageIndex.value = 1;
    // await fetchProduk();
  }

  void produkCustom() async {
    produkPageIndex.value = 2;
  }

  fetchProduk() async {
    if (isLoadingTakeProduk != true) {
      isLoadingProduk(true);
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String? url = prefs.getString('url');
    var dataUrl = 'http://$url/api/';

    var response = await Api.client.get(
      Uri.parse(
        '${dataUrl}modekasir/produk?take=${take}',
      ),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      print('');
      produkModel = ModeKasirProdukModel.fromJson(res);
      totalDataProduk.value = res['data']['totalData'];
      // print(produkModel?.data.data[]);
      // produkData.value = res;
    }
    if (isLoadingTakeProduk != true) {
      isLoadingProduk(false);
    }
  }

  fetchProdukRefresh() async {
    try {
      isLoadingProduk(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final String? url = prefs.getString('url');
      var dataUrl = 'http://$url/api/';

      var response = await Api.client.get(
        Uri.parse(
          '${dataUrl}modekasir/produk?take=20',
        ),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        print('');
        produkModel = ModeKasirProdukModel.fromJson(res);
        totalDataProduk.value = res['data']['totalData'];
        // print(produkModel?.data.data[]);
        // produkData.value = res;
      }
    } finally {
      isLoadingProduk(false);
    }
  }

  void takeProdukLain() async {
    try {
      isLoadingTakeProduk(true);
      take.value = take.toInt() + 20;
      await fetchProduk();
    } finally {
      // await Future.delayed(Duration(seconds: 1));
      isLoadingTakeProduk(false);
      // print(isLoadingTakeProduk);
    }
  }

  void startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((val) {
      if (val != -1) {
        barcode.value = val;
      }
    });
  }

  void scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      if (barcodeScanRes != -1) {
        barcode.value = barcodeScanRes;
        cariBarcode(barcode.value);
        // AudioPlayer audioPlayer = AudioPlayer();
        // audioPlayer.play(
        //   UrlSource('/assets/beep.mp3'),
        // );
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  void cariBarcode(barcode) async {
    // cek apakah barcode ada
    try {
      isLoadingProduk(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final String? url = prefs.getString('url');
      var dataUrl = 'http://$url/api/';

      var response = await Api.client.get(
        Uri.parse(
          '${dataUrl}modekasir/produk?barcode=${barcode}',
        ),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        produkModel = ModeKasirProdukModel.fromJson(res);
        totalDataProduk.value = res['data']['totalData'];
        // produkData.value = res;
        // print(produkModel?.data.data[]);
        // produkData.value = res['data']['data'];
        // print(res['data']['dataFind']);
        if (res['data']['dataFind'] != null) {
          // tambah Acc Cart
          // print(res['data']['dataFind']);
          addCartStorage(
            res['data']['dataFind']['produk_id'],
            res['data']['dataFind']['produk']['nama'],
            res['data']['dataFind']['produk']['merek_id'],
            res['data']['dataFind']['produk']['catalog_id'],
            res['data']['dataFind']['produk']['kategori_id'],
            res['data']['dataFind']['produk']['rak_id'],
            res['data']['dataFind']['id'],
            res['data']['dataFind']['satuan_id'],
            res['data']['dataFind']['harga_pokok'],
            res['data']['dataFind']['harga_jual'],
            res['data']['dataFind']['diskon_persen'],
            res['data']['dataFind']['satuan']['satuan'],
            res['data']['dataFind']['diskon_start'],
            res['data']['dataFind']['diskon_end'],
            res['data']['dataFind']['jam_start'],
            res['data']['dataFind']['jam_end'],
            res['data']['dataFind']['diskon_harga_jual'],
          );
        } else {
          print('tidak find');
        }
      }
      fetchCart();
    } finally {
      isLoadingProduk(false);
    }
  }

  void cariNamaProduk(namaProduk) async {
    try {
      isLoadingProduk(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final String? url = prefs.getString('url');
      var dataUrl = 'http://$url/api/';

      var response = await Api.client.get(
        Uri.parse(
          '${dataUrl}modekasir/produk?take=${30}&nama=${namaProduk}',
        ),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        // await Future.delayed(Duration(milliseconds: 2));
        var res = json.decode(response.body);
        produkModel = ModeKasirProdukModel.fromJson(res);
        totalDataProduk.value = res['data']['totalData'];
        // print(produkModel?.data.data[]);
        // produkData.value = res;

      } else {
        print('not found');
      }
    } finally {
      isLoadingProduk(false);
    }
  }

  var cartStorage = <Item>[].obs;
  var total_item = 0.obs;
  var qty = 0.obs;
  var subtotal = 0.obs;
  var potongan = 0.obs;
  var total_bayar = 0.obs;

  var pelanggan_id = null.obs;
  var pelanggan_nama = null.obs;
  var kas_id = null.obs;

  var total_harga_pokok = 0.obs;
  var total_harga_jual = 0.obs;
  var potongan_diskon = 0.obs;
  var total_harga = 0.obs;
  var total_pembayaran = 0.obs;
  var diterima = 0.obs;
  var kembali = 0.obs;

  var untung = 0.obs;

  void fetchCart() async {
    final cartData = Cart();
    var data = await cartData.getItems();
    if (data != null) {
      cartStorage.value = data;

      final prefs = await SharedPreferences.getInstance();
      final itemsJson = prefs.getStringList('items') ?? [];
      final items = itemsJson
          .map((itemJson) => Item.fromJson(json.decode(itemJson)))
          .toList();

      int htotal_item = 0;
      double hqty = 0;
      double hsubtotal = 0;
      double hpotongan = 0;
      double htotal_bayar = 0;

      double itotal_harga_modal = 0;
      double itotal_harga_jual = 0;
      double ipotongan = 0;
      double itotal_harga = 0;
      double itotal_pembayaran = 0;
      double iditerima = 0;
      double iuntung = 0;

      // print(itemsJson);
      for (var e in items) {
        htotal_item = items.length;
        hqty += e.qty;
        hsubtotal += e.totalHargaJual!;
        hpotongan += e.potonganDiskon!;
        htotal_bayar += e.totalHarga!;

        itotal_harga_modal += e.totalHargaModal!;
        itotal_harga_jual += e.totalHargaJual!;
        ipotongan += e.potonganDiskon!;
        itotal_harga += e.totalHarga!;
        itotal_pembayaran += e.totalHarga!;
        iuntung += e.untung!;
      }
      total_item.value = htotal_item.toInt();
      qty.value = hqty.toInt();
      subtotal.value = hsubtotal.toInt();
      potongan.value = hpotongan.toInt();
      total_bayar.value = htotal_bayar.toInt();

      total_harga_pokok.value = itotal_harga_modal.toInt();
      total_harga_jual.value = itotal_harga_jual.toInt();
      potongan_diskon.value = ipotongan.toInt();
      total_harga.value = itotal_harga.toInt();
      total_pembayaran.value = itotal_pembayaran.toInt();
      untung.value = iuntung.toInt();
    }
  }

  // void getTotal() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String> cartItems = prefs.getStringList('cart') ?? [];
  //   double totalPrice = 0;
  //   for (String item in cartItems) {
  //     Product product = Product.fromJson(jsonDecode(item));
  //     totalPrice += product.price;
  //   }
  //   return totalPrice;
  // }

  var addCartLoading = false.obs;
  var harga_jual_new;
  var persenDiskon;
  var user_id;
  void addCartStorage(
    produk_id,
    produk_nama,
    merek_id,
    catalog_id,
    kategori_id,
    rak_id,
    produk_item_id,
    satuan_id,
    harga_modal,
    harga_jual,
    diskon_persen,
    satuan,
    diskon_start,
    diskon_end,
    jam_start,
    jam_end,
    diskon_harga_jual,
  ) async {
    try {
      addCartLoading(true);
      animasiStart();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      Session.getUserId().then((val) {
        user_id = val;
      });

      DateTime now = DateTime.now();

      if (diskon_start != null && diskon_end != null) {
        DateTime dateDiskonStart = DateTime.parse(diskon_start);
        DateTime dateDiskonEnd = DateTime.parse(diskon_end);
        if (dateDiskonStart.isBefore(now) && dateDiskonEnd.isAfter(now)) {
          if (jam_start != null && jam_end != null) {
            DateTime jamDiskonStart = DateTime.parse(jam_start);
            DateTime jamDiskonEnd = DateTime.parse(jam_end);
            if (jamDiskonStart.isBefore(now) && jamDiskonEnd.isAfter(now)) {
              harga_jual_new = diskon_harga_jual;
              persenDiskon = diskon_persen;
            } else {
              harga_jual_new = harga_jual;
              persenDiskon = 0.0;
            }
          } else {
            harga_jual_new = diskon_harga_jual;
            persenDiskon = diskon_persen;
          }
        } else {
          harga_jual_new = harga_jual;
          persenDiskon = 0.0;
        }
      } else {
        harga_jual_new = harga_jual;
        persenDiskon = 0.0;
      }
      var waktuCreate = DateTime.now().millisecondsSinceEpoch;

      var item = Item(
        createdAt: waktuCreate,
        produkItemId: produk_item_id,
        kasirId: null,
        userId: user_id,
        produkId: produk_id,
        produkNama: produk_nama,
        merekId: merek_id,
        catalogId: catalog_id,
        kategoriId: kategori_id,
        rakId: rak_id,
        satuanId: satuan_id,
        satuan: satuan,
        hargaModal: double.parse(harga_modal),
        hargaJual: double.parse(harga_jual_new),
        qty: 1,
        diskonPersen: persenDiskon,
        diskonHargaJual: double.parse(diskon_harga_jual),
      );

      final cartData = Cart();
      final items = await cartData.getItems();
      final index =
          items.indexWhere((i) => i.produkItemId == item.produkItemId);

      if (index != -1) {
        // data item udh ada

        items[index].qty = items[index].qty + 1;
        items[index].totalHargaModal =
            items[index].hargaModal! * items[index].qty;
        items[index].totalHargaJual =
            items[index].hargaJual! * items[index].qty;
        items[index].potonganDiskon =
            (items[index].hargaJual! * (items[index].diskonPersen! / 100)) *
                items[index].qty;

        items[index].totalHarga =
            items[index].totalHargaJual! - items[index].potonganDiskon!;
        items[index].untung =
            items[index].totalHarga! - items[index].totalHargaModal!;

        // print(items[index].qty);
      } else {
        // data item baru

        item.qty = 1.0;
        item.totalHargaModal = item.hargaModal! * item.qty;
        item.totalHargaJual = item.hargaJual! * item.qty;
        item.potonganDiskon =
            item.hargaJual! * (item.diskonPersen! / 100) * item.qty;
        item.totalHarga = item.hargaJual! - item.potonganDiskon!;
        item.untung = item.totalHarga! - item.hargaModal!;

        items.add(item);
      }

      cartData.saveItems(items);

      // return print(item.produkNama);
      return print('');
    } catch (e) {
      print(e);
    } finally {
      fetchCart();
      // print(addCartLoading);
      falseLoadAdd();
      animasiEnd();
    }
  }

  void falseLoadAdd() async {
    await Future.delayed(Duration(milliseconds: 110));
    addCartLoading(false);
  }

  void tambahQtyCart(itemID) async {
    var cS = Cart();
    final items = await cS.getItems();
    final index = items.indexWhere((i) => i.produkItemId == itemID);
    if (index != -1) {
      items[index].qty = items[index].qty + 1;
      items[index].totalHargaModal =
          items[index].hargaModal! * items[index].qty;
      items[index].totalHargaJual = items[index].hargaJual! * items[index].qty;
      items[index].potonganDiskon =
          (items[index].hargaJual! * (items[index].diskonPersen! / 100)) *
              items[index].qty;
      items[index].totalHarga =
          items[index].totalHargaJual! - items[index].potonganDiskon!;
      items[index].untung =
          items[index].totalHarga! - items[index].totalHargaModal!;
    } else {
      print('tidak ada data item');
    }
    cS.saveItems(items);
    fetchCart();
  }

  void kurangQtyCart(itemID) async {
    var cS = Cart();
    final items = await cS.getItems();
    final index = items.indexWhere((i) => i.produkItemId == itemID);
    if (index != -1) {
      if (items[index].qty > 1) {
        items[index].qty = items[index].qty - 1;
        items[index].totalHargaModal =
            items[index].hargaModal! * items[index].qty;
        items[index].totalHargaJual =
            items[index].hargaJual! * items[index].qty;
        items[index].potonganDiskon =
            (items[index].hargaJual! * (items[index].diskonPersen! / 100)) *
                items[index].qty;
        items[index].totalHarga =
            items[index].totalHargaJual! - items[index].potonganDiskon!;
        items[index].untung =
            items[index].totalHarga! - items[index].totalHargaModal!;
      }
    } else {
      print('tidak ada data item');
    }
    cS.saveItems(items);
    fetchCart();
  }

  void deleteItemCart(params) async {
    var cS = Cart();
    cS.removeItem(params);
    fetchCart();
    await Future.delayed(Duration(milliseconds: 50));
    cS.removeItem(params);
    fetchCart();
  }

  void removeAllcartStorage() {
    var cS = Cart();
    cS.clearItems();
    inputKembaliC.clear();
    kembali.value = 0;

    billID.value = '';
    noDariBill.value = '';
    namaDariBill.value = '';
    fetchCart();
  }

  var validateUbahHarga;
  void simpanUbahHarga(itemID, harga_nego) async {
    var cS = Cart();
    final items = await cS.getItems();
    final index = items.indexWhere((i) => i.produkItemId == itemID);
    if (index != -1) {
      // items[index].qty = items[index].qty - 1;
      // items[index].totalHargaModal =
      //     items[index].hargaModal! * items[index].qty;

      // Lakukan perubahan storage Item
      // ubah harga jual
      items[index].hargaJual = harga_nego;
      //
      // yang ikut berubah
      items[index].totalHargaJual = harga_nego * items[index].qty;
      items[index].potonganDiskon =
          (harga_nego * (items[index].diskonPersen! / 100)) * items[index].qty;
      items[index].totalHarga =
          items[index].totalHargaJual! - items[index].potonganDiskon!;
      items[index].untung =
          items[index].totalHarga! - items[index].totalHargaModal!;
    } else {
      print('tidak ada data item');
    }
    cS.saveItems(items);
    fetchCart();
  }

// Bill
  var noDariBill = ''.obs;
  var namaDariBill = ''.obs;
  var jmlBill = 0.obs;
  void getBill() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String? url = prefs.getString('url');
    var dataUrl = 'http://$url/api/';

    var response = await Api.client.get(
      Uri.parse(
        '${dataUrl}bill',
      ),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
    );
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      jmlBill.value = res['data'].length;
    }
  }

  var loadingSimpanBill = false.obs;
  var namaPelanggan = ''.obs;

  var billID = ''.obs;

  void simpanBill() async {
    // cek jika pelanggan kosong
    loadingSimpanBill(true);
    final cartData = Cart();
    var data = await cartData.getItems();
    if (data != null) {
      cartStorage.value = data;
      final prefs = await SharedPreferences.getInstance();
      final itemsJson = prefs.getStringList('items') ?? [];
      final items = itemsJson
          .map((itemJson) => Item.fromJson(json.decode(itemJson)))
          .toList();

      final String? token = prefs.getString('token');
      final String? url = prefs.getString('url');
      var dataUrl = 'http://$url/api/';

      var response = await Api.client.post(
        Uri.parse(
          '${dataUrl}bill-simpan',
        ),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'pelanggan_nama': namaPelanggan.toString(),
          'total_harga_pokok': total_harga_pokok.toString(),
          'total_harga_jual': total_harga_jual.toString(),
          'potongan_diskon': potongan_diskon.toString(),
          'total_harga': total_harga.toString(),
          'total_pembayaran': total_pembayaran.toString(),
          'cartItem': itemsJson.toString(),
        },
      );
      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        print(res);

        billID.value = '';
        namaPelangganC.clear();
        namaPelanggan.value = '';
        getBill();
        removeAllcartStorage();
        Get.back();
        loadingSimpanBill(false);
        Get.snackbar('Berhasil', 'Berhasil buat bill');
      } else {
        print(response.body);
        loadingSimpanBill(false);
      }
    } else {
      // pilih produk dulu
      loadingSimpanBill(false);
    }
    loadingSimpanBill(false);
  }

  void perbaruiBill(id) {
    // perbarui, cara :
    // hapus bill_item lama, lalu
    // add bill item baru

    
  }

  var isLunas = true.obs;
// Transaksi
  void btnNominal(inputNominal) {
    // cari kembalian
    diterima.value = inputNominal;
    var kembaliH = inputNominal - total_bayar.value;
    kembali.value = kembaliH;
    fetchCart();
  }

  var loadingTransaksi = false.obs;
  void simpanTransaksi() async {
    loadingTransaksi(true);
    if (diterima.value == 0) {
      Get.defaultDialog(
          title: 'Belum pilih uang diterima',
          middleText: 'Pilih nominal tunai (uang diterima) atau uang pas',
          textCancel: '  Oke  ');
      loadingTransaksi(false);
    } else {
      final cartData = Cart();
      var data = await cartData.getItems();
      if (data != null) {
        cartStorage.value = data;
        final prefs = await SharedPreferences.getInstance();
        final itemsJson = prefs.getStringList('items') ?? [];
        final items = itemsJson
            .map((itemJson) => Item.fromJson(json.decode(itemJson)))
            .toList();

        final String? token = prefs.getString('token');
        final String? url = prefs.getString('url');
        var dataUrl = 'http://$url/api/';

        var response = await Api.client.post(
          Uri.parse(
            '${dataUrl}modekasir/simpan-penjualan',
          ),
          headers: {
            'Authorization': 'Bearer $token',
          },
          body: {
            'pelanggan_id': pelanggan_id.toString(),
            'pelanggan_nama': pelanggan_nama.toString(),
            'kasir_id': kasirid.toString(),
            // 'kas_id': 'null',
            'isLunas': isLunas.toString(),
            'isTunai': true.toString(),
            'total_harga_pokok': total_harga_pokok.toString(),
            'total_harga_jual': total_harga_jual.toString(),
            'potongan_diskon': potongan_diskon.toString(),
            'total_harga': total_harga.toString(),
            'ongkir': 0.toString(),
            'total_pembayaran': total_pembayaran.toString(),
            'diterima': diterima.toString(),
            'kembali': kembali.toString(),
            'untung': untung.toString(),
            'cartItem': itemsJson.toString(),
          },
        );
        if (response.statusCode == 200) {
          var res = json.decode(response.body);

          // print(res);
          // jika memiliki bill hapus
          if (billID.isNotEmpty) {
            var response2 = await Api.client.post(
              Uri.parse(
                '${dataUrl}bill-hapus',
              ),
              headers: {
                'Authorization': 'Bearer ${token}',
              },
              body: {
                'id': billID.toString(),
              },
            );
            if (response2.statusCode == 200) {
              var res = json.decode(response2.body);
              getBill();
              Get.put(BillPenjualanController()).getBill();
            }
          }

          // reset cart
          removeAllcartStorage();
          fetchCart();

          billID.value = '';
          diterima.value = 0;
          kembali.value = 0;
          Get.offNamed("/penjualan-detail/${res['data']['id']}");
          loadingTransaksi(false);
        } else {
          print(response.body);
          loadingTransaksi(false);
        }
        loadingTransaksi(false);
      } else {
        // pilih produk dulu
      }
    }
  }

  void bayarNanti() {
    diterima.value = 0;
    kembali.value = 0;
  }

  // void addCart(idItem) async {
  //   try {
  //     isLoadingProduk(true);
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     final String? token = prefs.getString('token');
  //     final String? url = prefs.getString('url');
  //     var dataUrl = 'http://$url/api/';

  //     var response = await Api.client.post(
  //       Uri.parse(
  //         '${dataUrl}modekasir/add-cart',
  //       ),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       },
  //       body: {
  //         'id': idItem,
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       // var res = json.decode(response.body);
  //     }
  //   } finally {
  //     isLoadingProduk(false);
  //     fetchCart();
  //   }
  // }
}
