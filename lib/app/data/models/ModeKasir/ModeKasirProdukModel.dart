// To parse this JSON data, do
//
//     final modeKasirProdukModel = modeKasirProdukModelFromJson(jsonString);

import 'dart:convert';

ModeKasirProdukModel modeKasirProdukModelFromJson(String str) =>
    ModeKasirProdukModel.fromJson(json.decode(str));

String modeKasirProdukModelToJson(ModeKasirProdukModel data) =>
    json.encode(data.toJson());

class ModeKasirProdukModel {
  static ModeKasirProdukModel? obs;

  ModeKasirProdukModel({
    required this.code,
    required this.status,
    required this.msg,
    required this.data,
  });

  int code;
  String status;
  String msg;
  Data data;

  factory ModeKasirProdukModel.fromJson(Map<String, dynamic> json) =>
      ModeKasirProdukModel(
        code: json["code"],
        status: json["status"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "msg": msg,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.totalData,
    required this.data,
  });

  int totalData;
  List<Datum> data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalData: json["totalData"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalData": totalData,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.produkId,
    this.img,
    this.barcode1,
    this.barcode2,
    this.barcode3,
    this.barcode4,
    this.barcode5,
    this.barcode6,
    required this.satuanId,
    required this.konversi,
    required this.hargaBeli,
    required this.hargaPokok,
    required this.hargaJual,
    required this.stokMinimum,
    required this.stokBeli,
    required this.stokTerjual,
    required this.stokJual,
    required this.stokBuku,
    this.opnameAt,
    required this.diskonHargaJual,
    required this.diskonPersen,
    this.diskonStart,
    this.diskonEnd,
    this.jamStart,
    this.jamEnd,
    required this.isaktif,
    required this.produk,
    required this.satuan,
  });

  int id;
  int produkId;
  dynamic img;
  String? barcode1;
  dynamic barcode2;
  dynamic barcode3;
  dynamic barcode4;
  dynamic barcode5;
  dynamic barcode6;
  int satuanId;
  int konversi;
  String hargaBeli;
  String hargaPokok;
  double hargaJual;
  String stokMinimum;
  String stokBeli;
  String stokTerjual;
  String stokJual;
  String stokBuku;
  dynamic opnameAt;
  String diskonHargaJual;
  String diskonPersen;
  DateTime? diskonStart;
  dynamic diskonEnd;
  dynamic jamStart;
  dynamic jamEnd;
  int isaktif;
  Produk produk;
  Satuan satuan;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        produkId: json["produk_id"],
        img: json["img"],
        barcode1: json["barcode1"],
        barcode2: json["barcode2"],
        barcode3: json["barcode3"],
        barcode4: json["barcode4"],
        barcode5: json["barcode5"],
        barcode6: json["barcode6"],
        satuanId: json["satuan_id"],
        konversi: json["konversi"],
        hargaBeli: json["harga_beli"],
        hargaPokok: json["harga_pokok"],
        hargaJual: double.parse(json["harga_jual"]),
        stokMinimum: json["stok_minimum"],
        stokBeli: json["stok_beli"],
        stokTerjual: json["stok_terjual"],
        stokJual: json["stok_jual"],
        stokBuku: json["stok_buku"],
        opnameAt: json["opname_at"],
        diskonHargaJual: json["diskon_harga_jual"],
        diskonPersen: json["diskon_persen"],
        diskonStart: json["diskon_start"] == null
            ? null
            : DateTime.parse(json["diskon_start"]),
        diskonEnd: json["diskon_end"],
        jamStart: json["jam_start"],
        jamEnd: json["jam_end"],
        isaktif: json["isaktif"],
        produk: Produk.fromJson(json["produk"]),
        satuan: Satuan.fromJson(json["satuan"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "produk_id": produkId,
        "img": img,
        "barcode1": barcode1,
        "barcode2": barcode2,
        "barcode3": barcode3,
        "barcode4": barcode4,
        "barcode5": barcode5,
        "barcode6": barcode6,
        "satuan_id": satuanId,
        "konversi": konversi,
        "harga_beli": hargaBeli,
        "harga_pokok": hargaPokok,
        "harga_jual": hargaJual,
        "stok_minimum": stokMinimum,
        "stok_beli": stokBeli,
        "stok_terjual": stokTerjual,
        "stok_jual": stokJual,
        "stok_buku": stokBuku,
        "opname_at": opnameAt,
        "diskon_harga_jual": diskonHargaJual,
        "diskon_persen": diskonPersen,
        "diskon_start":
            "${diskonStart!.year.toString().padLeft(4, '0')}-${diskonStart!.month.toString().padLeft(2, '0')}-${diskonStart!.day.toString().padLeft(2, '0')}",
        "diskon_end": diskonEnd,
        "jam_start": jamStart,
        "jam_end": jamEnd,
        "isaktif": isaktif,
        "produk": produk.toJson(),
        "satuan": satuan.toJson(),
      };
}

class Produk {
  Produk({
    required this.id,
    required this.nama,
    this.img,
    required this.tipe,
    this.merekId,
    this.catalogId,
    this.kategoriId,
    this.rakId,
    required this.isaktif,
    this.keterangan,
    this.supplierId,
  });

  int id;
  String nama;
  dynamic img;
  String tipe;
  dynamic merekId;
  dynamic catalogId;
  dynamic kategoriId;
  dynamic rakId;
  int isaktif;
  dynamic keterangan;
  dynamic supplierId;

  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
        id: json["id"],
        nama: json["nama"],
        img: json["img"],
        tipe: json["tipe"],
        merekId: json["merek_id"],
        catalogId: json["catalog_id"],
        kategoriId: json["kategori_id"],
        rakId: json["rak_id"],
        isaktif: json["isaktif"],
        keterangan: json["keterangan"],
        supplierId: json["supplier_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "img": img,
        "tipe": tipe,
        "merek_id": merekId,
        "catalog_id": catalogId,
        "kategori_id": kategoriId,
        "rak_id": rakId,
        "isaktif": isaktif,
        "keterangan": keterangan,
        "supplier_id": supplierId,
      };
}

class Satuan {
  Satuan({
    required this.id,
    required this.satuan,
    this.keterangan,
    required this.isaktif,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String satuan;
  dynamic keterangan;
  int isaktif;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Satuan.fromJson(Map<String, dynamic> json) => Satuan(
        id: json["id"],
        satuan: json["satuan"],
        keterangan: json["keterangan"],
        isaktif: json["isaktif"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "satuan": satuan,
        "keterangan": keterangan,
        "isaktif": isaktif,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
