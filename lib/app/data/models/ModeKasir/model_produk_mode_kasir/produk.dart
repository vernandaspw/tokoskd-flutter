class Produk {
  int? id;
  String? nama;
  dynamic img;
  String? tipe;
  dynamic merekId;
  dynamic catalogId;
  dynamic kategoriId;
  dynamic rakId;
  int? isaktif;
  dynamic keterangan;
  dynamic supplierId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Produk({
    this.id,
    this.nama,
    this.img,
    this.tipe,
    this.merekId,
    this.catalogId,
    this.kategoriId,
    this.rakId,
    this.isaktif,
    this.keterangan,
    this.supplierId,
    this.createdAt,
    this.updatedAt,
  });

  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
        id: json['id'] as int?,
        nama: json['nama'] as String?,
        img: json['img'] as dynamic,
        tipe: json['tipe'] as String?,
        merekId: json['merek_id'] as dynamic,
        catalogId: json['catalog_id'] as dynamic,
        kategoriId: json['kategori_id'] as dynamic,
        rakId: json['rak_id'] as dynamic,
        isaktif: json['isaktif'] as int?,
        keterangan: json['keterangan'] as dynamic,
        supplierId: json['supplier_id'] as dynamic,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'img': img,
        'tipe': tipe,
        'merek_id': merekId,
        'catalog_id': catalogId,
        'kategori_id': kategoriId,
        'rak_id': rakId,
        'isaktif': isaktif,
        'keterangan': keterangan,
        'supplier_id': supplierId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
