import 'produk.dart';

class Datum {
  int? id;
  int? produkId;
  dynamic img;
  dynamic barcode1;
  dynamic barcode2;
  dynamic barcode3;
  dynamic barcode4;
  dynamic barcode5;
  dynamic barcode6;
  int? satuanId;
  int? konversi;
  String? hargaBeli;
  String? hargaPokok;
  String? hargaJual;
  String? stokMinimum;
  String? stokBeli;
  String? stokTerjual;
  String? stokJual;
  String? stokBuku;
  dynamic opnameAt;
  String? diskonHargaJual;
  String? diskonPersen;
  dynamic diskonStart;
  dynamic diskonEnd;
  dynamic jamStart;
  dynamic jamEnd;
  int? isaktif;
  DateTime? createdAt;
  DateTime? updatedAt;
  Produk? produk;

  Datum({
    this.id,
    this.produkId,
    this.img,
    this.barcode1,
    this.barcode2,
    this.barcode3,
    this.barcode4,
    this.barcode5,
    this.barcode6,
    this.satuanId,
    this.konversi,
    this.hargaBeli,
    this.hargaPokok,
    this.hargaJual,
    this.stokMinimum,
    this.stokBeli,
    this.stokTerjual,
    this.stokJual,
    this.stokBuku,
    this.opnameAt,
    this.diskonHargaJual,
    this.diskonPersen,
    this.diskonStart,
    this.diskonEnd,
    this.jamStart,
    this.jamEnd,
    this.isaktif,
    this.createdAt,
    this.updatedAt,
    this.produk,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        produkId: json['produk_id'] as int?,
        img: json['img'] as dynamic,
        barcode1: json['barcode1'] as dynamic,
        barcode2: json['barcode2'] as dynamic,
        barcode3: json['barcode3'] as dynamic,
        barcode4: json['barcode4'] as dynamic,
        barcode5: json['barcode5'] as dynamic,
        barcode6: json['barcode6'] as dynamic,
        satuanId: json['satuan_id'] as int?,
        konversi: json['konversi'] as int?,
        hargaBeli: json['harga_beli'] as String?,
        hargaPokok: json['harga_pokok'] as String?,
        hargaJual: json['harga_jual'] as String?,
        stokMinimum: json['stok_minimum'] as String?,
        stokBeli: json['stok_beli'] as String?,
        stokTerjual: json['stok_terjual'] as String?,
        stokJual: json['stok_jual'] as String?,
        stokBuku: json['stok_buku'] as String?,
        opnameAt: json['opname_at'] as dynamic,
        diskonHargaJual: json['diskon_harga_jual'] as String?,
        diskonPersen: json['diskon_persen'] as String?,
        diskonStart: json['diskon_start'] as dynamic,
        diskonEnd: json['diskon_end'] as dynamic,
        jamStart: json['jam_start'] as dynamic,
        jamEnd: json['jam_end'] as dynamic,
        isaktif: json['isaktif'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        produk: json['produk'] == null
            ? null
            : Produk.fromJson(json['produk'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'produk_id': produkId,
        'img': img,
        'barcode1': barcode1,
        'barcode2': barcode2,
        'barcode3': barcode3,
        'barcode4': barcode4,
        'barcode5': barcode5,
        'barcode6': barcode6,
        'satuan_id': satuanId,
        'konversi': konversi,
        'harga_beli': hargaBeli,
        'harga_pokok': hargaPokok,
        'harga_jual': hargaJual,
        'stok_minimum': stokMinimum,
        'stok_beli': stokBeli,
        'stok_terjual': stokTerjual,
        'stok_jual': stokJual,
        'stok_buku': stokBuku,
        'opname_at': opnameAt,
        'diskon_harga_jual': diskonHargaJual,
        'diskon_persen': diskonPersen,
        'diskon_start': diskonStart,
        'diskon_end': diskonEnd,
        'jam_start': jamStart,
        'jam_end': jamEnd,
        'isaktif': isaktif,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'produk': produk?.toJson(),
      };
}
