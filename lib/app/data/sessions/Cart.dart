import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Item {
  Item({
    required this.createdAt,
    required this.produkItemId,
    this.kasirId,
    this.userId,
    this.produkId,
    this.produkNama,
    this.merekId,
    this.catalogId,
    this.kategoriId,
    this.rakId,
    this.satuanId,
    this.satuan,
    this.hargaModal,
    this.hargaJual,
    required this.qty,
    this.totalHargaModal,
    this.totalHargaJual,
    this.diskonPersen,
    this.diskonHargaJual,
    this.potonganDiskon,
    this.totalHarga,
    this.untung,
  });

  int produkItemId;
  int? kasirId;
  int? userId;
  int? produkId;
  String? produkNama;
  int? merekId;
  int? catalogId;
  int? kategoriId;
  int? rakId;
  int? satuanId;
  String? satuan;
  double? hargaModal;
  double? hargaJual;
  double qty;
  double? totalHargaModal;
  double? totalHargaJual;
  double? diskonPersen;
  double? diskonHargaJual;
  double? potonganDiskon;
  double? totalHarga;
  double? untung;
  int createdAt;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        createdAt: json['created_at'],
        produkItemId: json["produk_item_id"],
        kasirId: json['kasir_id'],
        userId: json['user_id'],
        produkId: json['produk_id'],
        produkNama: json['produk_nama'],
        merekId: json['merek_id'],
        catalogId: json['catalog_id'],
        kategoriId: json['kategori_id'],
        rakId: json['rak_id'],
        satuanId: json['satuan_id'],
        satuan: json['satuan'],
        hargaModal: json['harga_modal'],
        hargaJual: json['harga_jual'],
        qty: json['qty'],
        totalHargaModal: json['total_harga_modal'],
        totalHargaJual: json['total_harga_jual'],
        diskonPersen: json["diskon_persen"],
        diskonHargaJual: json["diskon_harga_jual"],
        potonganDiskon: json["potongan_diskon"],
        totalHarga: json["total_harga"],
        untung: json["untung"],
      );

  Map<String, dynamic> toJson() => {
        'created_at': createdAt,
        "produk_item_id": produkItemId,
        "kasir_id": kasirId,
        'user_id': userId,
        'produk_id': produkId,
        "produk_nama": produkNama,
        'merek_id': merekId,
        'catalog_id': catalogId,
        'kategori_id': kategoriId,
        'rak_id': rakId,
        'satuan_id': satuanId,
        'satuan': satuan,
        'harga_modal': hargaModal,
        'harga_jual': hargaJual,
        "qty": qty,
        'total_harga_modal': totalHargaModal,
        'total_harga_jual': totalHargaJual,
        'diskon_persen': diskonPersen,
        'diskon_harga_jual': diskonHargaJual,
        'potongan_diskon': potonganDiskon,
        'total_harga': totalHarga,
        'untung': untung,
      };
}

class Cart {
  static const _key = 'items';

  Future<List<Item>> getItems() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = prefs.getStringList(_key) ?? [];
    final items = itemsJson
        .map((itemJson) => Item.fromJson(json.decode(itemJson)))
        .toList();

    items.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    await prefs.setStringList(_key, itemsJson);
    return items;
  }

  Future<void> addItem(Item item) async {
    final items = await getItems();
    final index = items.indexWhere((i) => i.produkItemId == item.produkItemId);
    // print(item.produkId);

    if (index != -1) {
      print('1');
      items[index].qty += item.qty;
    } else {
      print('2');
      items.add(item);
    }
    print("cek");
    await saveItems(items);
  }

  Future<void> updateItem(Item item) async {
    final items = await getItems();
    final index = items.indexWhere((i) => i.produkItemId == item.produkItemId);
    if (index != -1) {
      items[index] = item;
    }
    await saveItems(items);
  }

  Future<void> removeItem(int itemId) async {
    final items = await getItems();
    // items.removeWhere((i) => i.produkItemId == itemId);
    final index = items.indexWhere((i) => i.produkItemId == itemId);
    print(index);
    if (index != -1) {
      items.remove(items[index]);
    } else {
      print('tidak ada data item');
    }

    await saveItems(items);
  }

  Future<void> clearItems() async {
    await saveItems([]);
  }

  Future<void> saveItems(List<Item> items) async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = items.map((item) => json.encode(item.toJson())).toList();
    await prefs.setStringList(_key, itemsJson);
  }
}
